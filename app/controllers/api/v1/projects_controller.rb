class Api::V1::ProjectsController < Api::V1::ApplicationController

  def create
    tasks = params[:tasks] # Array of task objects/dictionary

    @project = Project.new(project_params)

    if tasks.present?
      tasks.each do |task|
        task.permit!
        user_id = task[:user_id]
        user = User.find_by(pubid: user_id)
        task[:user_id] = user.id.to_s
        t = Task.new(task)
        @project.tasks << t
      end

      if @project.save

        # Get users
        all_users = []
        @project.tasks.each do |task|
          phone_num = task.user.phone_number
          all_users << phone_num unless all_users.include? phone_num
        end

        all_users.each do |phone_num|
          @nexmo =  Nexmo::Client.new(key: Rails.application.secrets.nexmo_key, 
                secret: Rails.application.secrets.nexmo_secret)
          foo = @nexmo.send_message(
            from: Rails.application.secrets.nexmo_number,
            to: phone_num,
            text: "You have new tasks in '@project.title'"
          )
        end

        return render_api_success("projects/show")
      else
        @error_msg = { msg: "#{@project.errors.full_message.to_sentence}" }
      end
    else
      @error_msg = { msg: "#{@project.errors.full_message.to_sentence}" }
    end
    render_api_error
  end

  def show
    @project = Project.find(params[:id])
    if @project.present?
      return render_api_success("projects/show")
    else
      @error_msg = { msg: "Project not found" }
    end
    render_api_error
  end

  def send_project_status
    @project = Project.find(params[:id])
    if @project.present?

      # Get users
      all_users = []
      @project.tasks.each do |task|
        phone_num = task.user.phone_number
        all_users << phone_num unless all_users.include? phone_num
      end

      sms_hash = {}
      all_users.each do |phone_num|
        user = User.find_by(phone_number: phone_num)
        total_tasks = user.tasks.where(project_id: @project.id)
        undone_tasks = user.tasks.where(project_id: @project.id, :status.ne => Task::DONE)
        hours = user.tasks.where(project_id: @project.id).pluck(:minutes).inject(&:+)
        estimate = user.tasks.where(project_id: @project.id).pluck(:estimate).inject(&:+)  

        @nexmo =  Nexmo::Client.new(key: Rails.application.secrets.nexmo_key, 
                      secret: Rails.application.secrets.nexmo_secret)
        foo = @nexmo.send_message(
          from: Rails.application.secrets.nexmo_number,
          to: phone_num,
          text: "You have #{undone_tasks.count}/#{total_tasks.count} tasks for #{@project.title}. " \
          "#{User.hours_string(hours, estimate)}"
        )
      end

      return render_api_success("projects/show")
    else
      @error_msg = { msg: "Project not found" }
    end
    render_api_error
  end

  private
  def project_params
    params.require(:project).permit(:title, :tasks_attributes => [])
  end

  # def task_params
  #   params.require(:task).permit(:minutes, :estimate, :description, :user_id)
  # end
end
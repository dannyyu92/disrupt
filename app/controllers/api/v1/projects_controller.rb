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

  private
  def project_params
    params.require(:project).permit(:title, :tasks_attributes => [])
  end

  # def task_params
  #   params.require(:task).permit(:minutes, :estimate, :description, :user_id)
  # end
end
class TextParser
  def initialize(text, from_number)
    @text = text
    @from_number = from_number
    @response = nil
  end

  def do_stuff
    argv = parse_args
    command = argv.first.downcase

    case command
    when "projects"
      @response = get_projects_response
    when "project"
      @response = "TASK ID | STATUS | DESCRIPTION | USER\n"
      @response += "--------------------------------"
      @response += "--------------------------------\n"
      @response = get_project_detail(argv[1])
    when "tasks"

      @response = get_tasks      
    when "task"
      @response = "TASK ID | STATUS | MIN. LOGGED | MIN. EST. | DESCRIPTION\n"
      @response += "--------------------------------"
      @response += "--------------------------------\n"
      @response = handle_task_commands(argv)
    end

    @response
  end


  private

  def parse_args
    @text.split(/\s/)
  end

  def incorrect_command
    "Go home you're drunk."
  end

  ##### Task Commands
  # Get all tasks assigned to the user
  def get_tasks
    table_header = "TASK ID | STATUS | MIN. LOGGED | MIN. EST. | DESCRIPTION\n"
    table_header += "--------------------------------"
    table_header += "--------------------------------\n"

    user = User.find_by(phone_number: @from_number)
    if user.present?
      final_mapping = Task.where(user_id: user.id).pluck(:pubid, :status, :minutes, :estimate, :description).join(" | ")
      table_header + final_mapping
    else
      "You currently have no tasks :)"
    end
  end

  # With args
  def handle_task_commands(argv)
    table_header = "TASK ID | STATUS | MIN. LOGGED | MIN. EST. | DESCRIPTION\n"
    table_header += "--------------------------------"
    table_header += "--------------------------------\n"

    task_id = argv[1]
    task = Task.find_by(pubid: task_id)
    if task.present?
      task_command = argv[2]
      if task_command.present?
        case task_command
        when "update"
          field = argv[3]
          new_value = argv[4..-1].join(" ")
          begin
            task.update_attributes(field.to_sym => new_value)
            return table_header + get_task_detail(task_id)
          rescue => e
            return "Go home you're drunk."
          end
        else
          incorrect_command
        end
      end
    else
      return "Task #{task_id} does not exist."
    end
  end

  def get_task_detail(task_id)
    Task.where(pubid: task_id).pluck(:pubid, :status, :minutes, :estimate, :description).join(" | ")
  end

  ### Project commands
  def get_projects_response
    table_header = "PROJ ID | NAME\n"
    table_header += "--------------------------------\n"
    projects = Project.all
    mapped_projects = projects.pluck(:pubid, :title)
    final_project_mapping = mapped_projects.map! do |x|
      x.join(" | ")
    end.join("\n")

    table_header + final_project_mapping
  end

  def get_project_detail(project_id)
    table_header = "TASK ID | STATUS | MIN. LOGGED | MIN. EST. | DESCRIPTION\n"
    table_header += "--------------------------------"
    table_header += "--------------------------------\n"

    p = Project.find_by(pubid: project_id)
    if p.present?
      tasks = p.tasks

      mapped_tasks = tasks.pluck(:pubid, :status, :minutes, :estimate, :description)
      tasks.each_with_index do |task, idx|
        mapped_tasks[idx] << task.user.name
      end

      final_project_mapping = mapped_tasks.map! do |x|
        x.join(" | ")
      end.join("\n")

      table_header + final_project_mapping
    else
      "Project #{project_id} does not exist."
    end
  end
end
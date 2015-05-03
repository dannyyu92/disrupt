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
      @response = get_project_detail(argv[1])
    when "task"
      @repsonse = handle_task_commands(argv)
    end

    @response
  end


  private

  def parse_args
    @text.split(/\s/)
  end

  def incorrect_command
    "Unknown command."
  end

  ##### Task Commands
  # Parse: "update"
  def handle_task_commands(argv)
    task_id = argv[1]
    task = Task.find_by(pubid: task_id)
    if task.present?
      task_command = argv[2]
      if task_command.present?
        case task_command
          when "update"
            field = argv[3]
            new_value = argv[3]
            task.update_attributes(field.to_sym => new_value)
            task.
          else
            incorrect_command
          end
        else
          incorrect_command
        end
      end
    else
      "Task #{task_id} does not exist."
    end
  end

  def get_task_detail(task)
    
  end

  ### Project commands
  def get_projects_response
    projects = Project.all
    mapped_projects = projects.pluck(:pubid, :title)
    final_project_mapping = mapped_projects.map! do |x|
      x.join(" | ")
    end.join("\n")
  end

  def get_project_detail(project_id)
    p = Project.find_by(pubid: project_id)
    if p.present?
      tasks = p.tasks

      mapped_tasks = tasks.pluck(:pubid, :status, :description)
      tasks.each_with_index do |task, idx|
        mapped_tasks[idx] << task.user.name
      end

      mapped_tasks.map! do |x|
        x.join(" | ")
      end.join("\n")
    else
      "Project #{project_id} does not exist."
    end
  end
end
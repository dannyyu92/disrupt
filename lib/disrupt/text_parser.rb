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
      task_command = argv[1]
      case task_command
      when "update"
        field = argv[2]
        case field
        when 

        else
          incorrect_command
        end
      else
        incorrect_command
      end

    else
      incorrect_command
    end

    @response
  end


  private

  def parse_args
    @text.split(/\s/)
  end

  def incorrect_command
    "Unknown command. Please select from: [projects]"
  end

  def get_projects_response
    projects = Project.all
    mapped_projects = projects.pluck(:pubid, :title)
    final_project_mapping = mapped_projects.map! do |x|
      x.join(" ")
    end.join("\n")
  end

  def get_project_detail(project_id)
    p = Project.find_by(pubid: project_id)
    tasks = p.tasks

    mapped_tasks = tasks.pluck(:pubid, :status, :description)
    tasks.each_with_index do |task, idx|
      mapped_tasks[idx] << task.user.name
    end

    mapped_tasks.map! do |x|
      x.join(" ")
    end.join("\n")
  end
end
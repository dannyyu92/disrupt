class TextParser
  def initialize(text, from_number)
    @text = text
    @from_number = from_number
    @response = nil
  end

  def do_stuff
    split_text = parse_args
    command = split_text.first

    case command
    when "projects"
      @response = get_projects_response
    when "project"
      @response = get_project_detail(split_text[1])
    else
      @response = incorrect_command
    end

    @response
  end


  private

  def parse_args
    @text.split(/\s/).map(&:downcase)
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
    
  end
end
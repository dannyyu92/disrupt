module JsonOutput
  extend ActiveSupport::Concern
  
  def render_api_success(view="/app/generic")
    render :template => "#{view_path}#{ensure_leading_slash(view)}", formats: [:json]
  end
  
  def render_api_error(view="/app/errors")
    @error_msg = { msg: "Something went wrong." }
    render :template => "#{view_path}#{ensure_leading_slash(view)}", formats: [:json]
  end

  private
  
  def view_path
    "/api/v1"
  end

  def ensure_leading_slash(path)
    (path.first == "/")? path : ("/" + path)
  end
end
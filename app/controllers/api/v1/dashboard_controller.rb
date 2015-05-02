class Api::V1::DashboardController < Api::V1::ApplicationController

  def index
    @projects = Project.all
    render_api_success("projects/index")
  end

end
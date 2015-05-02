class Api::V1::DashboardController < Api::V1::ApplicationController

  def index
    # API
    @api = Hash.new
    @api[:online] = true

    render_api_success("configs/app")
  end

end
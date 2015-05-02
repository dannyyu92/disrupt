class Api::V1::ConfigsController < Api::V1::ApplicationController

  def app_config
    # API
    @api = Hash.new
    @api[:online] = true

    render_api_success("configs/app")
  end

end
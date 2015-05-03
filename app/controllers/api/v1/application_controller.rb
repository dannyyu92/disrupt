class Api::V1::ApplicationController < ApplicationController
  include JsonOutput

  skip_before_action :verify_authenticity_token, if: :json_request?   # skip rails authenticity token check
  layout "api_v1"

  def json_request?
    request.format.json?
  end

  rescue_from(Mongoid::Errors::DocumentNotFound) do |e|
    # If raise_not_found_error: is not set to 'false' in mongoid.yml
    @error_msg = { msg: "Resource not found" }
    render_api_error
  end

end
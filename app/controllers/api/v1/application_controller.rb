class Api::V1::ApplicationController < ApplicationController
  include JsonOutput

  skip_before_action :verify_authenticity_token, if: :json_request?   # skip rails authenticity token check
  layout "api_v1"

  def json_request?
    request.format.json?
  end

end
class NexmoController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def sms
    puts request.method
    if request.method == "GET"

      head :ok
    else
      head :ok
    end
  end
end
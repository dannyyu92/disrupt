class NexmoController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def sms
    if request.method == "GET"
      from_number = params[:msisdn]
      text = params[:text]
      if text.nil?
        return head :ok
      end

      response = TextParser.new(text, from_number).do_stuff
      if response.present?
        @nexmo =  Nexmo::Client.new(key: Rails.application.secrets.nexmo_key, 
                    secret: Rails.application.secrets.nexmo_secret)
        @nexmo.send_message(
          from: Rails.application.secrets.nexmo_number,
          to: from_number,
          text: response)
      end
      head :ok
    else
      head :ok
    end
  end
end
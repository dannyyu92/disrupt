class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  rescue_from(Mongoid::Errors::UnknownAttribute) do |e|
    # If raise_not_found_error: is not set to 'false' in mongoid.yml
  end

end

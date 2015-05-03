Rails.application.routes.draw do
  
  constraints(:subdomain => /\b(api)\b/) do
    namespace :api, defaults: { format: "json" }, :path => "/" do
      scope module: :v1 do
        # Config routes
        get  "config/" => "configs#app_config"

        # Dashoard routes
        get  "dashboard/" => "dashboard#index"

        # Project routes
        get   "projects/:id" => "projects#show"
        post  "projects/create" => "projects#create"
        post  "projects/:id/send_project_status" => "projects#send_project_status"
      end
    end
  end

  # Nexmo
  post  "nexmo/sms" => "nexmo#sms"
  get   "nexmo/sms" => "nexmo#sms"

end

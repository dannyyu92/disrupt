Rails.application.routes.draw do
  
  constraints(:subdomain => /\b(api)\b/) do
    namespace :api, defaults: { format: "json" }, :path => "/" do
      scope module: :v1 do
        # Config routes
        get  "config/" => "configs#app_config"

        # Dashoard routes
        get  "dashboard/" => "dashboard#index"
      end
    end
  end

end

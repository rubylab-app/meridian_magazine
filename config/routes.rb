Rails.application.routes.draw do
  mount IronAdmin::Engine => "/admin"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "up" => "rails/health#show", as: :rails_health_check

  root to: redirect("/admin")
end

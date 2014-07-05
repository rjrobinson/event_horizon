Rails.application.routes.draw do
  root "assignments#index"

  resources :assignments, only: [:index, :show]
  resource :session, only: [:new, :create, :destroy]

  get "/auth/:provider/callback", to: "sessions#create"
end

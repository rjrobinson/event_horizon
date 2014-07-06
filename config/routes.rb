Rails.application.routes.draw do
  root "assignments#index"

  resources :assignments, only: [:index, :show] do
    resources :submissions, only: [:new, :create]
  end

  resources :submissions, only: [:show]

  resource :session, only: [:new, :create, :destroy] do
    get "failure", on: :member
  end

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
end

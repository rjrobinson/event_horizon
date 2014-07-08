Rails.application.routes.draw do
  root "assignments#index"

  resources :assignments, only: [:index, :show] do
    resources :submissions, only: [:index, :new, :create]
  end

  resources :submissions, only: [:show] do
    resources :comments, only: [:create]
  end

  resource :session, only: [:new, :create, :destroy] do
    get "failure", on: :member
  end

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
end

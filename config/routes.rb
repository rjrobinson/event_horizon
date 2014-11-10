Rails.application.routes.draw do
  root "static_pages#home"

  resources :lessons, only: [:index, :show], param: :slug do
    resources :submissions, only: [:index, :create]
    resources :ratings, only: [:create, :update]
  end

  resources :submissions, only: [:show, :update] do
    resources :comments, only: [:create]
  end

  resources :assignments, only: [:show]

  resources :users, only: [:index, :show], param: :username

  resources :teams, only: [:index, :show]

  resource :session, only: [:new, :create, :destroy] do
    get "failure", on: :member
  end

  resource :dashboard, only: [:show]

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"

  get "/start", to: "static_pages#start"
end

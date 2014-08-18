Rails.application.routes.draw do
  root "static_pages#home"

  resources :challenges, only: [:index, :show], param: :slug do
    resources :submissions, only: [:index, :new, :create]
  end

  resources :submissions, only: [:show] do
    resources :comments, only: [:create]
  end

  resources :users, only: [:index, :show]

  resource :session, only: [:new, :create, :destroy] do
    get "failure", on: :member
  end

  resource :search, only: [:show]

  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
end

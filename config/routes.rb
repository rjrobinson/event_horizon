Rails.application.routes.draw do
  root "assignments#index"

  resources :assignments, only: [:index, :show]
end

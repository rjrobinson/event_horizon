Rails.application.routes.draw do
  resources :assignments, only: [:index, :show]
end

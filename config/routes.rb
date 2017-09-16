Rails.application.routes.draw do
  devise_for :users
  root to: "dashboard#index"

  resources :tickets do
    resources :issues
  end
end

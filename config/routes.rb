Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: "dashboard#index"

  resources :tickets do
    resources :issues
  end
end

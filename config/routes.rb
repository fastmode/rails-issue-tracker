Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: "dashboard#index"
  get '/reports/closed_overdue_tickets', to: 'dashboard#show'

  resources :tickets do
    resources :issues
  end
end

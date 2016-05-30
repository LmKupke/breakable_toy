Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
  end
  resources :newsfeeds, only: [:index]
  resources :users, only: [:show]
  resources :events
  resources :venues, only: [:index, :show]
end

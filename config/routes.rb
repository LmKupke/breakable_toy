Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
  end

  resources :newsfeeds, only: [:index]
  resources :users, only: [:index,:show]
  resources :events
  get '/venues/search', to: 'venues#search', as: 'venue_search'

  resources :venues, only: [:index, :show, :create]

  resources :events, except: [:delete] do
    resources :venues, only: [:index, :show, :create]
    resources :invites, only: [:create]
  end

  resources :venueselections, only: [:create, :update, :delete]
  resources :invites, only: [:show, :index, :update]
end

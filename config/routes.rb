Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
  end

  resources :newsfeeds, only: [:index]
  resources :users, only: [:index,:show,:edit,:update]
  resources :events
  get '/venues/search', to: 'venues#search', as: 'venue_search'

  resources :venues, only: [:index, :show, :create]

  resources :events, only: [:show] do
    resources :venues, only: [:index, :show, :create]
    resources :invites, only: [:create]
  end

  resources :venueselections, only: [:create, :update, :delete]
  resources :invites, only: [:show, :index, :update]

  namespace :api do
    resources :newsfeeds, only: [:index]
    resources :venueselections, only: [:show] do
      resources :votes, only: [:upvote,:downvote,:index] do
        collection do
          post 'upvote'
          post 'downvote'
        end
      end
    end
  end
end

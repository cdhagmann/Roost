# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resource :session, only: :create
    post 'cluck', to: 'posts#create'
    get 'profile', to: 'users#profile'
    get 'clucks', to: 'followers#follows_posts'
    resources :roosters, controller: 'users' do
      post 'clucks/:id', to: 'posts#repost'
      resources :clucks, controller: 'posts' do
        delete 'favorites', to: 'favorites#destroy'
        post 'favorites', to: 'favorites#create'
        get 'favorites', to: 'favorites#index'
      end
      resources :followers
      get 'follows', to: 'followers#follows'
      get 'follows/:follows_id', to: 'followers#follows_show'
    end
  end
end

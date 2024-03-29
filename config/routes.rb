# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        resources :users, only: %i[index]
      end
      resources :tweets, only: %i[index show create destroy] do
        member do
          get :comments
          post :retweets
          post :favorites
        end
      end
      resources :comments, only: %i[create]
      resources :images, only: %i[update]
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/users/registrations'
      }
      resources :users, param: :name, only: %i[show update] do
        member do
          post :follow
          delete :unfollow
        end
      end
      resources :notifications, only: %i[index]
    end
  end
  resources :tasks
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

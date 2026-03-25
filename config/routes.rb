Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
  end

  resources :travel_spots, only: [ :index, :show ] do
    resources :travel_reviews, only: [ :new, :create, :edit, :update, :destroy ]
  end

  resources :travel_reviews, only: [ :index ]

  namespace :admin do
    get "/", to: "base#dashboard", as: :dashboard
    resources :posts
    resources :categories
    resources :tags
    resources :travel_spots
    resources :travel_reviews
    resources :users, only: [ :index, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

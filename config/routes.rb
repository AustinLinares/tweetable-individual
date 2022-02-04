Rails.application.routes.draw do
  resources :comments
  resources :tweets
  devise_for :users
  root to: "tweets#index"
end

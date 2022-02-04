Rails.application.routes.draw do
  resources :tweets do
    resources :comments
  end
  devise_for :users
  root to: "tweets#index"
end

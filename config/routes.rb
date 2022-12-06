Rails.application.routes.draw do
  resources :enrollements
  
  devise_for :users
  resources :courses do
    resources :enrollements, only: [:new, :create]
    resources :lessons
  end
  resources :users , only: [:index, :edit, :show, :update]
  get 'home/activity'
  
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

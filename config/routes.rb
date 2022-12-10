Rails.application.routes.draw do
  devise_for :users, default: { format: :json }, controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                       passwords: "users/passwords",
                       unlocks: "users/unlocks",
                       confirmations: "users/confirmations",
                     }

  root to: "users#index"

  resources :users, only: [:show] do
    resources :posts, only: [:create, :new, :index, :show, :destroy] do
      resources :comments, only: [:create, :new, :destroy]
      resources :likes, only: [:create]
    end
  end

  namespace :api do
    resources :users, only: [] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  root to: "users#index"

  resources :users, only: [:show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :new]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

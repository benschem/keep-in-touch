Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :show, :create, :update, :destroy]  do
        resources :contacts, only: [:create, :update, :destroy]
      end
    end
  end
end

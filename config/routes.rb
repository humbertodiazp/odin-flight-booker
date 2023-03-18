Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'flights#index'
  resources :flights, only: %i[index]
  resources :bookings, only: %i[new create show]
end
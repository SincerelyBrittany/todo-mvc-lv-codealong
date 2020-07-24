Rails.application.routes.draw do
  root 'lists#index'
  resources :users, except: [:new]

  get "/signup" => "users#new", as: "signup"
  get "/login" => "sessions#new", as: "login"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get 'items/create'
  resources :lists do 
    resources :items
  end 
end

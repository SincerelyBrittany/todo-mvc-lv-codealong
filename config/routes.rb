Rails.application.routes.draw do
  resources :lists
  # get 'site/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'site#index'
  root 'lists#index'
end

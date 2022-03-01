Rails.application.routes.draw do
 
  resources :sessions, only: %i[new create destroy]
  resources :users
  resources :blogs
  resources :favorites, only: %i[create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users, only: [:show, :edit]

  get "/login", to: "sessions#login"
  post "/login", to: "sessions#login_verify"
  post "/logout", to: "sessions#logout"

  get "/signup", to: "sessions#signup"
  post "/signup", to: "users#create"

  post "users/:id/follow", to: "users#follow", as: "follow"
  post "users/:id/unfollow", to: "users#unfollow", as: "unfollow"

end

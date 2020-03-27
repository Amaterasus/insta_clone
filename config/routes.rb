Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/users/change_password", to: "users#change_password", as: "change_password"
  resources :posts
  resources :users, only: [:show, :edit, :update,]

  root to: "users#explore"

  get "/login", to: "sessions#login"
  post "/login", to: "sessions#login_verify"
  post "/logout", to: "sessions#logout"

  get "/signup", to: "sessions#signup"
  post "/signup", to: "users#create"

  get "/explore", to: "users#explore", as: "explore"
  get "/home", to: "users#home", as: "home"

  post "posts/:id/like", to: "posts#like", as: "like"
  post "posts/:id/unlike", to: "posts#unlike", as: "unlike"
  get "posts/:id/post_likes", to: "posts#post_likes", as: "post_likes"

  get "/users/:id/user_followers", to: "users#user_followers", as: "user_followers"
  get "/users/:id/user_followees", to: "users#user_followees", as: "user_followees"
  
  post "users/update_password", to:"users#update_password", as: "update_password"
  post "users/:id/follow", to: "users#follow", as: "follow"
  post "users/:id/unfollow", to: "users#unfollow", as: "unfollow"


  post "posts/:id/comment", to: "posts#make_comment", as: "make_comment"
end

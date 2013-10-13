Hrmap::Application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "/hr"              => "hr#index",       as: :hr
  get "/settings"        => "settings#index", as: :settings
  get "/profile"         => "users#show",     as: :user
  get "/posts/:category" => "posts#index",    as: :posts

  root to: "posts#index"
end

Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: [:index, :show]
  get "profile", to: "pages#profile"

  namespace :admin do
    resources :posts
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

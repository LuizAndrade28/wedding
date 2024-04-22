Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :weddings, only: %i[new create] do
    resources :guests, only: %i[new create update]
    resources :gifts, only: %i[new create] do
      resources :orders, only: %i[create]
    end
    resources :tips, only: %i[new create edit update]
  end
  get "presentes", to: "gifts#index", as: :presentes
  get "presentes/:gift_id/comprar", to: "orders#new", as: :buy_gift
  get "/dashboard", to: "users#show", as: :user_profile
end

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :weddings, except: :show do
    resources :guests, only: %i[new create edit update destroy]
    member do
      delete "delete_all_guests", to: "guests#delete_all"
    end
    resources :gifts, only: %i[new create edit update destroy] do
      resources :orders, only: %i[create]
    end
    delete "delete_all_gifts", to: "gifts#delete_all"
    resources :tips, only: %i[new create edit update destroy]
  end
  get "presentes", to: "gifts#index", as: :presentes
  get "presentes/:gift_id/comprar", to: "orders#new", as: :buy_gift
  get "/dashboard", to: "users#show", as: :user_profile
end

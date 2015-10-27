Rails.application.routes.draw do

  devise_for :users, skip: [:sessions, :registrations]

  devise_scope :user do
    get    "login"   => "devise/sessions#new",         as: :new_user_session
    post   "login"   => "devise/sessions#create",      as: :user_session
    delete "signout" => "devise/sessions#destroy",     as: :destroy_user_session

    get    "signup"  => "devise/registrations#new",    as: :new_user_registration
    post   "signup"  => "devise/registrations#create", as: :user_registration
    put    "signup"  => "devise/registrations#update", as: :update_user_registration
    get    "account" => "devise/registrations#edit",   as: :edit_user_registration
  end

  namespace :admin do
    resources :products
    resources :users
    resources :orders, only: [:index, :show, :destroy]
  end

  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create] do
      member do
        get 'like'
      end
    end

    member do
      get 'like'
      get 'add_to_cart'
    end
  end

  get 'cart/:user_id', to: 'carts#show', as: 'cart'
  delete 'cart/:id', to: 'carts#destroy'

  root 'products#index'

end

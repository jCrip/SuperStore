Rails.application.routes.draw do

  get 'locations/get_address'

  devise_for :users, skip: [:sessions, :registrations]

  devise_scope :user do
    get    "login"   => "devise/sessions#new",         as: :new_user_session
    post   "login"   => "devise/sessions#create",      as: :user_session
    delete "signout" => "devise/sessions#destroy",     as: :destroy_user_session

    get    "signup"  => "devise/registrations#new",    as: :new_user_registration
    post   "signup"  => "devise/registrations#create", as: :user_registration
    put    "signup"  => "devise/registrations#update", as: :update_user_registration
    get    "account" => "devise/registrations#edit",   as: :edit_user_registration
    get    "users"   => "devise/registrations#edit",   as: :user_root
  end

  namespace :admin do
    get '/', to: 'pages#index'

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

  get 'cart', to: 'carts#show', as: 'cart'
  delete 'cart/:id', to: 'carts#destroy'

  get 'order', to: 'orders#create_order', as: 'create_order'
  get 'order/:id', to: 'orders#show', as: 'order'
  post 'order/:id', to: 'orders#paid_order', as: 'paid_order'
  delete 'order/:id', to: 'orders#cancel_order', as: 'cancel_order'

  get 'get_address', to: 'locations#get_address'

  root 'products#index'

end

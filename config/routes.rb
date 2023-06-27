Rails.application.routes.draw do  
  root 'static_pages#home'

  get '/contacts', to: 'static_pages#contacts'
  get '/about',    to: 'static_pages#about'
  get '/privacy',  to: 'static_pages#privacy'

  post 'search', to: 'search#index'
  delete 'reset_search_dates', to: 'search#destroy'

  devise_for :partners, controllers:  {
                          sessions:      'partners/sessions',
                          registrations: 'partners/registrations',
                          confirmations: 'partners/confirmations',
                          passwords:     'partners/passwords',
                        }

  devise_for :customers,  controllers: {
                            sessions:      'customers/sessions',
                            registrations: 'customers/registrations',
                            confirmations: 'customers/confirmations',
                            passwords:     'customers/passwords',
                            omniauth_callbacks: 'customers/omniauth_callbacks'
                          }

  namespace :partners do
    root 'dashboard#index'
    get 'orders', to: 'dashboard#orders'
    get 'profile', to: 'dashboard#profile'
    get 'add_listing', to: 'dashboard#add_listing'
  end

  namespace :customers do
    root 'dashboard#index'
    get 'new_customer', to: 'customers#new', as: 'new_customer'
    post 'create_customer'  , to: 'customers#create', as: 'create_customer' 
  end

  resources :properties do
    resources :rooms, except: %i[index show], shallow: true
    post :calculate_price, on: :member
  end

  delete 'images/:id/purge', to: 'images#purge', as: 'purge_image'

  resources :orders, only: %i[show new create update]

  resources :towns, only: %i[show] do
    get :properties, on: :member
  end

  resources :carts, only: [:show, :destroy]

  # for tests
  # default_url_options :host => "example.com"
end

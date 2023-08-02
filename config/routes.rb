Rails.application.routes.draw do
  authenticate :partner, lambda { |p| p.admin?  } do
    namespace :admin do
      resources :listings, only: %i[index] do
        get 'properties',   on: :collection
        get 'activities',   on: :collection
        get 'services',     on: :collection
        get 'places',       on: :collection
        get 'food_places',  on: :collection
      end
      patch 'listings/:id/activate_listing', to: 'listings#activate_listing', as: 'activate_listing'
      patch 'listings/:id/deactivate_listing', to: 'listings#deactivate_listing', as: 'deactivate_listing'
      # toggle listing activating status
      patch 'listings/:id/toggle_listing_activating', to: 'listings#toggle_listing_activating', as: 'toggle_listing_activating'
    end
  end

  # Images Carrierwave
  concern :imagable do
    resources :images, only: [:destroy]
  end
  # Images Active storage (deprecated)
  # delete 'images/:id/purge', to: 'images#purge', as: 'purge_image'

  root 'static_pages#home'

  get '/contacts',  to: 'static_pages#contacts'
  get '/about',     to: 'static_pages#about'
  get '/privacy',   to: 'static_pages#privacy'
  get '/agreement', to: 'static_pages#agreement'

  get 'search', to: 'search#index'
  delete 'reset_search_dates', to: 'search#destroy'

  devise_for :partners, controllers:  {
                          sessions:      'partners/sessions',
                          registrations: 'partners/registrations',
                          confirmations: 'partners/confirmations',
                          passwords:     'partners/passwords',
                        },
                        path: 'partners',
                        path_names: { edit: 'profile' }

  namespace :partners do
    root 'dashboard#index'
    get 'orders', to: 'dashboard#orders'    
    get 'bookings', to: 'dashboard#bookings'
    get 'add_listing', to: 'dashboard#add_listing'
    get 'info', to: 'dashboard#info'
  end

  resources :properties, concerns: %i[imagable] do
    resources :rooms, except: %i[index show], shallow: true
    resources :bookings, only: %i[new create]
    post :calculate_price, on: :member
  end

  resources :activities, concerns: %i[imagable]
  resources :services, concerns: %i[imagable]
  resources :places, concerns: %i[imagable]
  resources :food_places, concerns: %i[imagable]

  resources :towns, only: %i[index show] do
    get :properties, on: :member
    get :activities, on: :member
    get :services, on: :member
    get :places, on: :member
    get :food_places, on: :member
  end

  resources :carts, only: [:show, :destroy]
end

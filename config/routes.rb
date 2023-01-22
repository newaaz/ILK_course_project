Rails.application.routes.draw do  
  root 'static_pages#home'

  # static pages
  get '/contacts', to: 'static_pages#contacts'
  get '/about', to: 'static_pages#about'
  get '/privacy', to: 'static_pages#privacy'

  devise_for :partners, controllers:  {
    sessions:           'partners/sessions',
    registrations:      'partners/registrations',
    confirmations:      'partners/confirmations',
    passwords:          'partners/passwords',
  }

  devise_for :customers, controllers: {
    sessions:           'customers/sessions',
    registrations:      'customers/registrations',
    confirmations:      'customers/confirmations',
    passwords:          'customers/passwords',
  }

  namespace :partners do
    root 'dashboard#index'
    get 'orders', to: 'dashboard#orders'
  end

  namespace :customers do
    root 'dashboard#index'
  end

  resources :properties do
    resources :rooms, except: %i[index show], shallow: true
  end

  delete 'images/:id/purge', to: 'images#purge', as: 'purge_image'

  resources :orders, only: %i[show new create update]

  resources :towns, only: %i[show]
end

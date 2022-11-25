Rails.application.routes.draw do
  root 'static_pages#home' 

  devise_for :owners, controllers: {
    sessions:           'owners/sessions',
    registrations:      'owners/registrations',
    confirmations:      'owners/confirmations',
    passwords:          'owners/passwords'
  }

  devise_for :customers, controllers: {
    sessions:           'customers/sessions',
    registrations:      'customers/registrations',
    confirmations:      'customers/confirmations',
    passwords:          'customers/passwords',
    # omniauth_callbacks: 'customers/omniauth_callbacks'
  }

  namespace :owners do
    root 'dashboard#index'
    get '/dashboard', to: 'dashboard#main'
  end

  resources :towns do
    get :hotels, on: :member
  end

  resources :categories, except: %i[show]

  resources :properties
end

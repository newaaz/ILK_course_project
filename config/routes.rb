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

  namespace :admin do
    root 'dashboard#index'
    resources :towns, except: %i[show]
    resources :categories, except: %i[show]
  end

  namespace :owners do
    root 'dashboard#index'
  end

  namespace :customers do
    root 'dashboard#index'
  end

  resources :towns, only: %i[show] do
    get :hotels, on: :member
  end

  resources :properties, except: :index do
    resources :rooms, except: %i[index show], shallow: true
  end

  resources :orders, only: %i[show new create]

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment' 
end

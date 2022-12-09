Rails.application.routes.draw do  
  root 'static_pages#home'

  devise_for :partners, controllers:  {
    sessions:           'partners/sessions',
    registrations:      'partners/registrations',
    confirmations:      'partners/confirmations',
    passwords:          'partners/passwords',
  }

  namespace :partners do
    root 'dashboard#index'
  end

  resources :properties do
    resources :rooms, except: %i[index show], shallow: true
  end
end

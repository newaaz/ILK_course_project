Rails.application.routes.draw do  
  root 'static_pages#home'

  devise_for :partners, controllers:  {
    sessions:           'partners/sessions',
    registrations:      'partners/registrations',
    confirmations:      'partners/confirmations',
    passwords:          'partners/passwords',
    # omniauth_callbacks: 'partners/omniauth_callbacks'
  }





end

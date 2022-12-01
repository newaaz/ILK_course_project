Rails.application.routes.draw do  
  root 'static_pages#home'

  devise_for :partners, path: 'partners', controllers:  {
    sessions:           'partners/sessions',
    registrations:      'partners/registrations',
    confirmations:      'partners/confirmations',
    passwords:          'partners/passwords',
    # omniauth_callbacks: 'partners/omniauth_callbacks'
  }

  # static pages
  get '/contacts', to: 'static_pages#contacts'
  get '/about', to: 'static_pages#about'
  get '/admin', to: 'static_pages#admin'
  get '/privacy', to: 'static_pages#privacy'
end

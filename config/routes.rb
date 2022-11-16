Rails.application.routes.draw do
  root 'static_pages#home'

  # static pages
  get '/contacts', to: 'static_pages#contacts'
  get '/about', to: 'static_pages#about'
  get '/admin', to: 'static_pages#admin'
  get '/privacy', to: 'static_pages#privacy'
end

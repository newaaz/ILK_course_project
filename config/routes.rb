Rails.application.routes.draw do
  root 'static_pages#home'

  resources :towns do
    get :hotels, on: :member
  end

  resources :categories, except: :show
end

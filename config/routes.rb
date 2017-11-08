Rails.application.routes.draw do
  # get 'accommodation/index'
  # get 'accommodation/new'
  # get 'accommodation/create'
  # get 'accommodation/listing'
  # get 'accommodation/pricing'
  # get 'accommodation/description'
  # get 'accommodation/photo_upload'
  # get 'accommodation/amenities'
  # get 'accommodation/location'
  # get 'accommodation/update'

  root "pages#home"

  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration',
              controllers: {omniauth_callbacks: 'omniauth_callbacks'}
              }

  # resources :users, only: [:show]

  resources :accommodations, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
    end
    resources :photos, only: [:create, :destroy]
      #only allow user to create reservation
    resources :reservations, only: [:create]
  end

  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]
end

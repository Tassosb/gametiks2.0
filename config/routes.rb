Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations' }

  root 'static_pages#home'
  # get '/forum'    =>  'static_pages#forum'
  get '/contact' =>  'static_pages#contact'

  resources :users
  resources :conversations do
    resources :messages
  end
  resources :harvests, except: [:show]
  resources :user_contacts, only: [:create, :destroy]

end

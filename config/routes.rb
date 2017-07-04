Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations' }

  root 'static_pages#home'
  get '/gallery' => 'harvests#index'
  get '/forum'    =>  'static_pages#forum'
  get '/contact' =>  'static_pages#contact'

  resources :users
  resources :harvests

end

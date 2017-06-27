Rails.application.routes.draw do

  #root 'avatars#index'
  root 'static_pages#home'
  #get '/gallery' => 'harvests#index'
  get '/forum'    =>  'static_pages#forum'
  get '/contact' =>  'static_pages#contact'
  get '/signup'  =>  'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :harvests
  
end

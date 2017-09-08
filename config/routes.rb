Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/store'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations' }

  root 'static_pages#home'
  get '/contact' =>  'static_pages#contact'
  get '/gallery' => 'harvests#index'

  resources :users
  get '/user-harvests' => 'users#harvests'
  resources :harvests, except: [:show] do
    resources :comments, only: [:create, :destroy]
  end
  resources :notifications, only: [:index]
  match 'mark_read' => 'notifications#mark_read', via: :post
  match 'credit', to: 'credits#credit', via: :post
  resources :user_contacts, only: [:create, :destroy]
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

end

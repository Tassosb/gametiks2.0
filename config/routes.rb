Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations' }

  root 'static_pages#home'
  get '/contact' =>  'static_pages#contact'

  resources :users
  resources :harvests, except: [:show] do
    resources :comments, only: [:create, :destroy]
  end
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

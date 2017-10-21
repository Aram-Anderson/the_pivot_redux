Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

  resources :confirmations, only: [:new, :create]

  get '/password-reset', :to => 'confirmations#new'
  post '/password-reset', :to => 'confirmations#create'
  patch '/password-confirmation', :to => 'passwords#update'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]
  end


  resources :users , only: [:new, :create, :edit, :update]

  resources :items, only: [:index, :show]

  resources :orders, only: [:index, :new, :show, :update]

  resources :dashboard, only: [:index]

  get '/cart', :to => 'carts#index', :as => 'cart'

  namespace :store, path: ':store_slug', as: :store do
    resources :items, only: [:index, :show]
  end

  resources :carts, only: [:index, :create, :destroy]

  patch '/cart', :to => 'carts#update'

  delete '/cart', :to => 'carts#destroy'
  resources :carts, only: [:index, :create, :destroy]

  get '/:category', to: 'categories#show', param: :slug, as: "category"

end

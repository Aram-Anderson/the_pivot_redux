Rails.application.routes.draw do

  get 'platform_admin/index'

  root :to => 'main#index'

  get '/auth/twitter', to: 'sessions#create', as: 'twitter_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

  get '/password-reset', to: 'passwords#new', as: 'new_password_reset'
  post '/password-reset', to: 'passwords#create', as: 'password_reset'

  get '/password-confirmation', to: 'confirmations#new', as: 'new_password'
  post '/password-confirmation', to: 'passwords#update', as: 'edit_password'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]
  end

  namespace :store, path: ':store_slug', as: :store do
    resources :admin, only: [:index]
    namespace :admin do
      get "/edit", to: "store#edit"
      patch "/", to: "store#update"
    end

    namespace :manager do
      resources :dashboard, only: [:index]
      resources :items, only: [:index]
      resources :orders, only: [:index]
      resources :items, only: [:edit, :update]
    end
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

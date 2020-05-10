Rails.application.routes.draw do
  root 'posts#home'

  get 'home' => 'posts#home'
  get '/about' => 'static_pages#about'
  get '/help' => 'static_pages#help'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/following' => 'users#following'
  get '/followers' => 'users#followers'
  get '/password_resets/logged_in_edit' => 'password_resets#logged_in_edit'
  patch '/password_resets/logged_in_update' => 'password_resets#logged_in_update'

  resources :profiles, only: [:create, :edit, :update]
  resources :contacts, only: [:new, :create, :index, :show]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]

  resources :users do
    get '/keeps' => 'keeps#index'
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :keeps, only: [:create, :destroy]
    resources :comments, only: [:index, :create, :destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end

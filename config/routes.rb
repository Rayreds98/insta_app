Rails.application.routes.draw do
  root 'posts#home'

  get '/about' => 'static_pages#about'
  get '/help' => 'static_pages#help'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/password_resets/new' => 'password_resets#new'
  get '/password_resets/edit' => 'password_resets#edit'

  resources :users
  resources :profiles, only: [:create, :edit, :update]
  resources :posts
  resources :contacts, only: [:new, :index, :show]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end

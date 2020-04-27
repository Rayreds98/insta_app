Rails.application.routes.draw do
  root 'static_pages#home'

  get '/about' => 'static_pages#about'
  get '/help' => 'static_pages#help'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users
  resources :contacts, only: [:new, :index, :show]
  resources :account_activations, only: [:edit]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end

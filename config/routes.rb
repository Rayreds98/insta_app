Rails.application.routes.draw do
  root 'static_pages#home'

  get '/about' => 'static_pages#about'
  get '/help' => 'static_pages#help'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :contacts, only: [:new, :index, :show]
  resources :users

end

Rails.application.routes.draw do
  get 'albums/new'

  get 'sessions/new'

  root                'static_pages#home'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get    'h_create'=> 'hospitals#new'
  get    'map'     => 'hospitals#map'

  resources :users
  resources :hospitals
  #resources :reservations
  #resources :talks
  resources :meetings
    
end

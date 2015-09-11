Rails.application.routes.draw do
  get 'albums/new'

  get 'sessions/new'

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get    'map'     => 'static_pages#map'

  resources :users
  resources :hospitals
  resources :reservations
  resources :talks
    
end

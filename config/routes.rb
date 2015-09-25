Rails.application.routes.draw do
  #resources :events
  
  get 'albums/new'

  get 'sessions/new'

  root                'static_pages#home'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get    'h_create'=> 'hospitals#new'

  resources :users do
    resources :reviews
  end
  resources :hospitals do 
    resources :meetings
    resources :reviews
  end
  #resources :reservations
  #resources :talks
    
end
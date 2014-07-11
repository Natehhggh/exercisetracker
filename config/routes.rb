Rails.application.routes.draw do
  devise_for :users
  resources :users

  #resources :sessions, only: [:new, :create, :destroy]
  root 'static_pages#home'
  match '/help',				to: 'static_pages#help',			via:	'get'
  #match '/signup',			to: 'users#new',					via:	'get'
  #match '/signin',  			to: 'devise/sessions#new',         		via:	'get'
  #match '/signout', 		to: 'devise/sessions#destroy',     	via: 	'delete'
  resources :exercises do
	resources :weight_logs, shallow: true
  end
  
  devise_scope :user do
	get "signin", to: "devise/sessions#new"
	get "signup", to: "devise/registrations#new"
	
  end

end

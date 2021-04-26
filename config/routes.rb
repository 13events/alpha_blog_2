Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#home'

  get 'about', to: 'welcome#about' 

  #New user signup route
  get 'signup', to: 'users#signup'

  #Login routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, except: [:new]
  resources :articles
  resources :categories, except: [:destroy]
end
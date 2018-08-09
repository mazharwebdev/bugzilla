Rails.application.routes.draw do
  

  get 'dashboard/index'

  devise_for :users
  resources :projects
  resources :bugs do
    resources :comments, except: [:show, :edit]
  end  
  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

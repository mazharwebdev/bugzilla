Rails.application.routes.draw do
  get 'bug/index'

  get 'dashboard/index'

  devise_for :users
  resources :projects
  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

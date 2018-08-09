Rails.application.routes.draw do
  

  get 'dashboard/index'

  devise_for :users
  resources :projects
  resources :bugs do
    resources :comments, except: [:show, :edit]   
  end
  resources :votes

  match 'upvote', to: 'votes#upvote', via: :post

  match 'downvote', to: 'votes#downvote', via: :delete 

  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

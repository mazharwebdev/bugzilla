Rails.application.routes.draw do
  

  get 'docsigns/index'

  get 'dashboard/index'

  devise_for :users
  resources :projects
  resources :bugs do
    resources :comments, except: [:show, :edit]   
  end
  resources :votes

  match 'upvote', to: 'votes#upvote', via: :post

  match 'downvote', to: 'votes#downvote', via: :post 

  root 'dashboard#index'

  match '/docsigns',      to: 'docsigns#sending_doc',        via: 'post'

  resources :docsigns do
  collection do
    get 'status_env'
    get 'sending_doc'
    get 'get_doc'
    get 'not_sending_doc'
    get 'embedded_signing'
    get 'docusign_response'
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

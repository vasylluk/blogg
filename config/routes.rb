Rails.application.routes.draw do
  get 'photos/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "pages#index"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do 
  	resources :postcomments
  end

   resources :photos do
    member do
      get :vote
    end
  end
   
end
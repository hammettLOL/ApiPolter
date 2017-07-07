Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard/index'
  end

  mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
  end
  
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :records, only: [:index, :show, :new, :create, :destroy, :update] do 
        resources :users, only: [:index, :show]
      end
      # resources :audios, only: [:index, :show] 
      resources :bookmarks, only: [:index, :show, :new, :create, :destroy, :update] do 
        resources :users, only: [:index, :show]
        resources :records, only: [:index, :show]
      end
      # resources :audios, only: [:index, :show]
      resources :users, only: [:index, :show] do
      end
    end
  end
end

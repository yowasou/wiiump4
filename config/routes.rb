Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :users do
    member {
      get :icon
    }
  end
end

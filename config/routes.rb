Rails.application.routes.draw do
  root 'pages#home'
  resources :mines, only: [:new, :show, :create, :edit, :update]
end

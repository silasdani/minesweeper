Rails.application.routes.draw do
  root 'mines#new'
  resources :mines
end

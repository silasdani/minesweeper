Rails.application.routes.draw do
  root 'mines#new'
  resources :mines, only: %i[index show new create edit update] do
    member do
      get 'reveal'
    end
  end
end

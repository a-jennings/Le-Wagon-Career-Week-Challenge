Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'locations#new'
  resources :locations, only: [:new, :create, :show]
end

Rails.application.routes.draw do
  root 'games#index'
  resources :games do
    resources :moves
  end
end

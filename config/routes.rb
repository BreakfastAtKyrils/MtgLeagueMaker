Rails.application.routes.draw do
  root to: 'players#index'
  resources :players, only: %i[index show]
  resources :decks
  resources :games
end

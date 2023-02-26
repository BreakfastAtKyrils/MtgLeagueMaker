Rails.application.routes.draw do
  root to: 'players#index'
  resources :players do
    resources :decks
  end
  resources :decks, only: %i[create new index show edit update destroy]
  resources :games, only: %i[index]
end

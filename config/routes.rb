Rails.application.routes.draw do
  root to: 'players#index'
  resources :players do
    resources :decks
  end
  resources :decks
  resources :games, only: %i[index]
end

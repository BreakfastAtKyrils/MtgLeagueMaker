Rails.application.routes.draw do
  get 'game/new'
  get 'game/create'
  root to: 'players#index'
  resources :players do
    resources :decks
  end
  resources :decks
  resources :games
end

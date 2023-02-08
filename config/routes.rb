Rails.application.routes.draw do
  root to: 'players#index'
  get 'decks/index'
  get 'decks/show'
  resources :players, only: %i[index show]
end

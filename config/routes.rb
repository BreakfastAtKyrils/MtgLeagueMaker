Rails.application.routes.draw do
  root to: 'players#index'
  resources :players, only: %i[create index new show]
  resources :decks, only: %i[index show]
  resources :games, only: %i[index]
end

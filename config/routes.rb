Rails.application.routes.draw do
  root to: 'players#index'
  delete 'players/:id', to: 'players#destroy'
  resources :players, only: %i[create index new show edit update destroy]
  resources :decks, only: %i[index show]
  resources :games, only: %i[index]
end

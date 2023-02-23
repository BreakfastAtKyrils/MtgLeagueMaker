Rails.application.routes.draw do
  root to: 'players#index'
  resources :players, only: %i[create index new show edit update destroy]
  resources :decks, only: %i[create new index show destroy]
  resources :games, only: %i[index]
end

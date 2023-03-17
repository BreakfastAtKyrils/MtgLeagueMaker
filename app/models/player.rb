class Player < ApplicationRecord
  validates :name, presence: true
  has_many :decks, dependent: :destroy
  has_many :game_records, dependent: :destroy
end

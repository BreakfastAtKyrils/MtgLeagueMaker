class Player < ApplicationRecord
  validates :name, presence: true
  has_many :decks, dependent: :destroy
end

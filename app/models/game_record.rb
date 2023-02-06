class GameRecord < ApplicationRecord
  validates :record_type, presence: true
  belongs_to :player
  belongs_to :game
  belongs_to :deck
end

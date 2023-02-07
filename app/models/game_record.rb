class GameRecord < ApplicationRecord
  validates :result, presence: true
  belongs_to :player
  belongs_to :game
  belongs_to :deck
  enum :result, %i[loss win draw]
end

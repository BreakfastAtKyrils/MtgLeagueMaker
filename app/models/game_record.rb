class GameRecord < ApplicationRecord
  belongs_to :player
  belongs_to :game
  belongs_to :deck
  enum :result, %i[loss win draw], allow_blank: true
end

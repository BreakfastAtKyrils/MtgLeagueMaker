class Game < ApplicationRecord
  validates :played_at, presence: true
  has_many :game_records, dependent: :destroy
end

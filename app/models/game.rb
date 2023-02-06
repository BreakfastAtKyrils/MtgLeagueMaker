class Game < ApplicationRecord
  validates :played_at, presence: true
end

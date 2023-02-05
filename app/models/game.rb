class Game < ActiveRecord
  validates :played_at, presence: true
end

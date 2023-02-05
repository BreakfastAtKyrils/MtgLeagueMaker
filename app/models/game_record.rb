class GameRecord < ActiveRecord
  validates :player_id, presence: true
  validates :deck_id, presence: true
  validates :record_type, presence: true
  validates :game_id, presence: true
end

class Game < ApplicationRecord
  validates :played_at, presence: true
  validates :state, presence: true
  enum :state, %i[pending completed]
  has_many :game_records, dependent: :destroy
  accepts_nested_attributes_for :game_records
end

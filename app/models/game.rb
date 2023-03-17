class Game < ApplicationRecord
  validates :played_at, presence: { message: I18n.t(:invalid_game_date) }
  validates :state, presence: true
  validates_with GameValidator

  enum :state, %i[pending completed]
  has_many :game_records, dependent: :destroy
  accepts_nested_attributes_for :game_records, allow_destroy: true
end

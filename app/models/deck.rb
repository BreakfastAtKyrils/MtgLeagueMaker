class Deck < ApplicationRecord
  validates :name, presence: true
  belongs_to :player
  has_many :game_records, dependent: :destroy
end

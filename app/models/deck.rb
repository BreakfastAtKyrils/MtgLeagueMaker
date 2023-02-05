class Deck < ActiveRecord
  validates :name, presence: true
  belongs_to :player
end

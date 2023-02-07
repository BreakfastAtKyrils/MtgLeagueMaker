FactoryBot.define do
  factory :game_record do
    player
    game
    deck
    result { 0 }
  end
end

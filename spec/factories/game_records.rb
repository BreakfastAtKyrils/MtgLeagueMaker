FactoryBot.define do
  factory :game_record do
    player
    game
    deck
    result { :loss }
  end
end

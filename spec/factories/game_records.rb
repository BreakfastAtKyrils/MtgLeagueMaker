FactoryBot.define do
  factory :game_record do
    player
    game
    deck
    record_type { 'MyString' }
  end
end

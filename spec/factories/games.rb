FactoryBot.define do
  factory :game do
    played_at { Time.current }
    state { :pending }

    factory :game_with_records do
      transient do
        game_records_count { 2 }
      end

      after(:build) do |game, evaluator|
        evaluator.game_records_count.times do |index|
          id = index + 1
          player = build(:player, id: id)
          deck = build(:deck, id: id, player_id: player.id)
          game.game_records << build(:game_record, player: player, deck: deck, result: :draw)
        end
      end
    end
  end
end

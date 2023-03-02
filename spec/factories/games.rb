FactoryBot.define do
  factory :game do
    played_at { Time.current }
    state { 0 }
  end
end

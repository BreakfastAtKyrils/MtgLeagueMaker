FactoryBot.define do
  factory :game do
    played_at { Time.current }
  end
end

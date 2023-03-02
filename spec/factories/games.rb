FactoryBot.define do
  factory :game do
    played_at { Time.current }
    state { :pending }
  end
end

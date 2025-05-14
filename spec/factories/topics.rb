FactoryBot.define do
  factory :topic do
    title { Faker::Lorem.sentence(word_count: 3) }
    slug { title.parameterize }
  end
end

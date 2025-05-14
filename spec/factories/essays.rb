# frozen_string_literal: true

FactoryBot.define do
  factory :essay do
    title { Faker::Book.title + " - " + rand(1..1000).to_s }
    body { "# #{title}\n\nGenerated content for essay." }
    visible { true }
    first_published_at { nil }
    system_slug { nil }

    # Automatically generate slug from title unless provided
    slug { title.parameterize }

    # Traits
    trait :published do
      first_published_at { Time.current }
    end

    trait :unpublished do
      visible { false }
      first_published_at { nil }
    end

    trait :invisible do
      visible { false }
    end

    # System pages (magic essays)
    trait :system_index do
      title { "Home" }
      slug { "index" }
      system_slug { "index" }
      body { "# Welcome\n\nThis is your home page." }
      visible { true }
      first_published_at { Time.current }
    end

    trait :system_about do
      title { "About" }
      slug { "about" }
      system_slug { "about" }
      body { "# About\n\nThis is the about page." }
      visible { true }
      first_published_at { Time.current }
    end

    trait :system_topics do
      title { "Topics" }
      slug { "topics" }
      system_slug { "topics" }
      body { "# Topics\n\n{% topics %}" }
      visible { true }
      first_published_at { Time.current }
    end
  end
end

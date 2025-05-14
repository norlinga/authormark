require 'rails_helper'

RSpec.describe Topic, type: :model do
  subject { build(:topic) }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:slug) }

  it { should have_many(:essays).through(:essay_topics) }

  describe "slug generation" do
    it "generates slug from title on create" do
      topic = create(:topic, title: "Test Driven Development", slug: nil)

      expect(topic.slug).to eq("test-driven-development")
    end

    it "does not override an explicitly set slug" do
      topic = create(:topic, title: "Custom", slug: "custom-slug")

      expect(topic.slug).to eq("custom-slug")
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe EssayTopicManager do
  let(:essay) { create(:essay) }
  let(:topic1) { create(:topic) }
  let(:topic2) { create(:topic) }

  subject { described_class.new(essay) }

  describe "#add" do
    it "adds the topic" do
      subject.add(topic1)
      expect(essay.topics).to include(topic1)
    end

    it "sets the topic as primary if it's the first" do
      subject.add(topic1)
      expect(essay.primary_topic).to eq(topic1)
    end

    it "does not override existing primary" do
      essay.topics << topic2
      essay.update!(primary_topic: topic2)

      subject.add(topic1)
      expect(essay.primary_topic).to eq(topic2)
    end
  end

  describe "#remove" do
    before do
      essay.topics << topic1
      essay.topics << topic2
      essay.update!(primary_topic: topic1)
    end

    it "removes the topic" do
      subject.remove(topic1)
      expect(essay.topics).not_to include(topic1)
    end

    it "reassigns primary if primary is removed" do
      subject.remove(topic1)
      expect(essay.primary_topic).to eq(topic2)
    end

    it "clears primary if it was the only topic" do
      essay.topics = [ topic1 ]
      essay.update!(primary_topic: topic1)

      subject.remove(topic1)
      expect(essay.primary_topic).to be_nil
    end
  end

  describe "#promote" do
    it "adds the topic if not already added" do
      subject.promote(topic1)
      expect(essay.topics).to include(topic1)
    end

    it "sets the topic as primary" do
      subject.promote(topic1)
      expect(essay.primary_topic).to eq(topic1)
    end
  end
end

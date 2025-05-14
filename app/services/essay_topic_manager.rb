# frozen_string_literal: true

class EssayTopicManager
  def initialize(essay)
    @essay = essay
  end

  def add(topic)
    return if @essay.topics.include?(topic)

    @essay.topics << topic
    promote_if_first_topic(topic)
  end

  def remove(topic)
    @essay.topics.delete(topic)
    drop_or_reassign_primary(topic)
  end

  def promote(topic)
    add(topic) # ensures topic is added before promoting
    @essay.update!(primary_topic: topic)
  end

  private

  def promote_if_first_topic(topic)
    if @essay.topics.size == 1
      @essay.update!(primary_topic: topic)
    end
  end

  def drop_or_reassign_primary(topic)
    return unless @essay.primary_topic == topic

    new_primary = @essay.topics.first
    @essay.update!(primary_topic: new_primary)
  end
end

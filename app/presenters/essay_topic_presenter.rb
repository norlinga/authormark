# frozen_string_literal: true

class EssayTopicPresenter
  def initialize(essay:, topic:, view:)
    @essay = essay
    @topic = topic
    @view = view
  end

  def included?
    @essay.topics.include?(@topic)
  end

  def primary?
    @essay.primary_topic == @topic
  end

  def topic_id
    @topic.id
  end

  def title
    @topic.title
  end

  def title_class
    "font-medium #{'text-green-600' if included?}"
  end

  def promote_button
    if primary?
      @view.content_tag(:span, @view.render("shared/heroicons/solid_star"), class: "text-yellow-500")
    else
      @view.button_tag(type: "button", class: "text-yellow-500", data: { action: "topic-panel#promote" }) do
        @view.render("shared/heroicons/star")
      end
    end
  end

  def action_buttons
    if included?
      remove = @view.button_tag(type: "button", class: "text-red-600", data: { action: "topic-panel#remove" }) do
        @view.render("shared/heroicons/minus_circle")
      end

      [ remove, promote_button ]
    else
      add = @view.button_tag(type: "button", class: "text-green-600", data: { action: "topic-panel#add" }) do
        @view.render("shared/heroicons/plus_circle")
      end

      [ add, promote_button ]
    end
  end
end

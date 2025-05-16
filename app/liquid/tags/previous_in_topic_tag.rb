# frozen_string_literal: true

module Tags
  class PreviousInTopicTag < Liquid::Tag
    def render(context)
      essay = context.registers[:essay]

      return "" unless essay.is_a?(Essay) && essay.primary_topic

      previous_essay = Essay
        .listable
        .where(primary_topic: essay.primary_topic)
        .where("first_published_at < ?", essay.first_published_at)
        .order(first_published_at: :desc)
        .first

      return "" unless previous_essay

      "[← #{previous_essay.title}](#{Rails.application.routes.url_helpers.essay_page_path(slug: previous_essay.slug)})"
    end
  end
end

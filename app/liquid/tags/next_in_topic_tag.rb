class NextInTopicTag < Liquid::Tag
  def render(context)
    essay = context.registers[:essay]

    return "" unless essay.is_a?(Essay) && essay.primary_topic

    next_essay = Essay
      .listable
      .where(primary_topic: essay.primary_topic)
      .where("first_published_at > ?", essay.first_published_at)
      .order(first_published_at: :asc)
      .first

    return "" unless next_essay

    "[#{next_essay.title} →](#{Rails.application.routes.url_helpers.essay_page_path(slug: next_essay.slug)})"
  end
end

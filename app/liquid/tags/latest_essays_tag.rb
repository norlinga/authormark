# frozen_string_literal: true

class LatestEssaysTag < Liquid::Tag
  def initialize(tag_name, markup, tokens)
    super
    @limit = markup.strip.to_i.nonzero? || 5
  end

  def render(context)
    essays = Essay.visible.listable.order(first_published_at: :desc).limit(@limit)

    essays.map do |essay|
      "- [#{essay.title}](#{Rails.application.routes.url_helpers.essay_page_path(slug: essay.slug)})"
    end.join("\n")
  end
end

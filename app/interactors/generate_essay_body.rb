# frozen_string_literal: true

# This is the content render pipeline.  Pass a slug to this
# Interactor::Organizer as `.call(slug: "index")` to get the body of the essay
# with that slug.  The slug is the part of the URL after the domain name.
# For example, the slug for the URL `https://example.com/index` is `index`.
# A slug not found will return a failure and will render the not found page.
class GenerateEssayBody
  include Interactor::Organizer

  organize FindEssayBySlug, RenderEssayWithLiquid, RenderEssayWithMarkdown
end

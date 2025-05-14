# frozen_string_literal: true

class RenderEssayWithMarkdown
  include Interactor

  def call
    # if the liquid step isn't run, parse markdown directly
    content_to_parse = context.liquid_parsed_body || context.essay.body
    context.markdown_parsed_body = Commonmarker.to_html(content_to_parse)
  rescue StandardError => e
    context.fail!(error: e.message)
  end
end

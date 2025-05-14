# frozen_string_literal: true

class RenderEssayWithLiquid
  include Interactor

  def call
    # this is where we set up the ability to call
    # {{ essay.title }} and {{ essay.primary_topic }}
    # add other essay or topic attribute accessors here
    template_context = {
      "essay" => {
        "title" => context.essay.title,
        "primary_topic" => context.essay&.primary_topic&.title
      }
    }

    template = Liquid::Template.parse(context.essay.body, environment: LiquidEnv.instance)
    rendered = template.render(template_context, registers: { essay: context.essay })
    context.liquid_parsed_body = rendered
  rescue Liquid::SyntaxError => e
    context.fail!(error: e.message)
  end
end

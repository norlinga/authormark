# frozen_string_literal: true

class FindEssayBySlug
  include Interactor

  def call
    context.essay = Essay.find_by!(slug: context.slug)
  rescue ActiveRecord::RecordNotFound
    context.fail!(error: "Essay not found")
  end
end

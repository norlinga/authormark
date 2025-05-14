class PagesController < ApplicationController
  def show
    result = GenerateEssayBody.call(slug: params[:slug])
    if result.success?
      @essay = result.markdown_parsed_body
      render :show
    else
      @essay = result.error
      render :show, status: :not_found
    end
  end
end

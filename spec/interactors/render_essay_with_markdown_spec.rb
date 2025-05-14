# frozen_string_literal: true

require "rails_helper"

RSpec.describe RenderEssayWithMarkdown, type: :interactor do
  let(:essay) { create(:essay) }
  let(:context) { described_class.call(essay: essay) }

  describe "#call" do
    context "when the essay body has a markdown header" do
      it "parses the markdown correctly" do
        expect(context.markdown_parsed_body).to include("<h1")
      end
    end
  end
end

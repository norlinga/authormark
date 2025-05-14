# frozen_string_literal: true

require "rails_helper"

RSpec.describe FindEssayBySlug, type: :interactor do
  let(:slug) { "example-slug" }
  let(:context) { described_class.call(slug: slug) }

  describe ".call" do
    context "when the essay is found" do
      let!(:essay) { create(:essay, slug: slug) }

      it "sets the essay in the context" do
        expect(context.essay).to eq(essay)
      end
    end

    context "when the essay is not found" do
      it "fails with an error message" do
        expect(context).to be_failure
        expect(context.error).to eq("Essay not found")
      end
    end
  end
end

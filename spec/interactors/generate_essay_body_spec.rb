# frozen_string_literal: true

require "rails_helper"

RSpec.describe GenerateEssayBody, type: :interactor do
  before do
    allow(FindEssayBySlug).to receive(:call!).and_return(true)
    allow(RenderEssayWithLiquid).to receive(:call!).and_return(true)
    allow(RenderEssayWithMarkdown).to receive(:call!).and_return(true)
  end

  it "calls the interactors in order" do
    GenerateEssayBody.call(slug: "about")

    expect(FindEssayBySlug).to have_received(:call!).ordered
    expect(RenderEssayWithLiquid).to have_received(:call!).ordered
    expect(RenderEssayWithMarkdown).to have_received(:call!).ordered
  end

  it "organizes the correct interactors in order" do
    expect(described_class.organized).to eq([
      FindEssayBySlug,
      RenderEssayWithLiquid,
      RenderEssayWithMarkdown
    ])
  end
end

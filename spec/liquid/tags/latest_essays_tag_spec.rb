# frozen_string_literal: true

require "rails_helper"

RSpec.describe "LatestEssaysTag", type: :liquid do
  def render_liquid(source, assigns: {})
    environment = LiquidEnv.instance
    Liquid::Template.parse(source, environment: environment).render(assigns)
  end

  describe "{% latest_essays %}" do
    before do
      @essays = create_list(:essay, 3, visible: true, first_published_at: 3.days.ago)
      @newest = create(:essay, visible: true, title: "Newest Essay", first_published_at: 1.hour.ago)
    end

    it "renders a Markdown list of the latest 5 essays by default" do
      output = render_liquid("{% latest_essays %}")

      expect(output).to include("- [Newest Essay]")
      expect(output.lines.count { |line| line.start_with?("- [") }).to eq(4) # 3 + 1 created
    end

    it "respects a limit if provided" do
      output = render_liquid("{% latest_essays 2 %}")
      lines = output.lines.select { |l| l.start_with?("- [") }

      expect(lines.size).to eq(2)
      expect(lines.first).to include("Newest Essay")
    end
  end
end

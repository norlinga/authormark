require 'rails_helper'

RSpec.describe "pages/show.html.erb", type: :view do
  it "renders the body of the essay" do
    assign(:essay, build_stubbed(:essay, body: "This is the essay body.").body)

    render

    expect(rendered).to include("This is the essay body.")
  end
end

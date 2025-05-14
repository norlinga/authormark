# frozen_string_literal: true

require "rails_helper"

RSpec.describe SiteImage, type: :model do
  it "can have an attached image" do
    site_image = SiteImage.new
    site_image.image.attach(
      io: File.open(Rails.root.join("spec/fixtures/files/sample.jpg")),
      filename: "sample.jpg",
      content_type: "image/jpeg"
    )

    expect(site_image.image).to be_attached
  end
end

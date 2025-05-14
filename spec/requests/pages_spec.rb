# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "returns http success" do
      create(:essay, :system_index)

      get home_page_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      create(:essay, :system_about)

      get about_page_path
      expect(response).to have_http_status(:success)
    end
  end
end

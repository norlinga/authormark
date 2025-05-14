# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "System (magic) pages", type: :request do
  describe "GET / (home page)" do
    it "renders the index essay content" do
      create(:essay, :system_index, body: "Hello, world!")

      get home_page_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Hello, world!")
    end
  end

  describe "GET /about" do
    it "renders the about essay content" do
      create(:essay, :system_about, body: "This is the about page.")

      get about_page_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("This is the about page.")
    end
  end

  describe "when essay does not exist" do
    it "raises ActiveRecord::RecordNotFound for /about" do
      get about_page_path
      expect(response).to have_http_status(:not_found)
    end
  end
end

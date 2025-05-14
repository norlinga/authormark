# frozen_string_literal: true

require "rails_helper"

RSpec.describe SiteSetting, type: :model do
  describe ".[]" do
    it "returns the value for a given key from the DB if not cached" do
      SiteSetting.create!(key: "site_title", value: "My Site")
      expect(SiteSetting["site_title"]).to eq("My Site")
    end

    it "caches the value after first read" do
      SiteSetting.create!(key: "site_title", value: "My Site")
      expect(Rails.cache).to receive(:fetch).with("site_setting:site_title").and_call_original
      SiteSetting["site_title"]
    end
  end

  describe ".[]=" do
    it "creates a setting if it doesn't exist" do
      expect {
        SiteSetting["new_setting"] = "abc"
      }.to change { SiteSetting.count }.by(1)

      expect(SiteSetting.find_by(key: "new_setting").value).to eq("abc")
    end

    it "updates an existing setting" do
      SiteSetting.create!(key: "existing", value: "old")
      SiteSetting["existing"] = "new"
      expect(SiteSetting.find_by(key: "existing").value).to eq("new")
    end

    it "writes to the cache" do
      expect(Rails.cache).to receive(:write).with("site_setting:write_test", "val")
      SiteSetting["write_test"] = "val"
    end
  end

  describe "after_commit :bust_cache!" do
    it "removes the cached value after update" do
      SiteSetting["cache_test"] = "123"
      expect(SiteSetting["cache_test"]).to eq("123")

      SiteSetting["cache_test"] = "456"

      expect(SiteSetting["cache_test"]).to eq("456")
    end
  end
end

# frozen_string_literal: true

class SiteSetting < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  after_commit :bust_cache!

  def self.[](key)
    Rails.cache.fetch("site_setting:#{key}") do
      find_by(key: key)&.value
    end
  end

  def self.[]=(key, value)
    setting = find_or_initialize_by(key: key)
    setting.value = value
    setting.save!
    Rails.cache.write("site_setting:#{key}", value)
  end

  private

  def bust_cache!
    Rails.cache.delete("site_setting:#{key}")
  end
end

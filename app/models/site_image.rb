# frozen_string_literal: true

class SiteImage < ApplicationRecord
  has_one_attached :image
end

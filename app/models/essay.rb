# frozen_string_literal: true

# An Essay is THE content type for Authormark. It is a markdown
# document that can be published and is used to create the
# content of the system. It is also used to create the
# navigation of the system.
class Essay < ApplicationRecord
  has_many :essay_topics, dependent: :destroy
  has_many :topics, through: :essay_topics

  belongs_to :primary_topic, class_name: "Topic", optional: true

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true
  validates :primary_topic, inclusion: { in: ->(essay) { essay.topics.to_a }, allow_nil: true }

  before_validation :generate_slug, on: :create
  before_validation :normalize_system_slug

  before_save :set_first_published_at_if_needed

  scope :visible, -> { where(visible: true) }
  scope :published, -> { where.not(first_published_at: nil) }
  scope :listable, -> { where(system_slug: [ nil, "" ]) }
  scope :system_pages, -> { where.not(system_slug: [ nil, "" ]) }

  # Prevent destroying magic pages
  before_destroy :prevent_destroy_if_system_slug!

  private

  def normalize_system_slug
    self.system_slug = nil if system_slug.blank?

    # Check uniqueness if present
    if system_slug.present?
      existing = Essay.where(system_slug: system_slug)
      existing = existing.where.not(id: id) if persisted?

      if existing.exists?
        errors.add(:system_slug, "has already been taken")
        throw(:abort)
      end
    end
  end

  def generate_slug
    self.slug ||= title.parameterize if title.present?
  end

  def set_first_published_at_if_needed
    if will_save_change_to_visible? && visible? && first_published_at.blank?
      self.first_published_at = Time.current
    end
  end

  def prevent_destroy_if_system_slug!
    if system_slug.present?
      errors.add(:base, "Cannot destroy system pages")
      throw :abort
    end
  end
end

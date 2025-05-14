class Topic < ApplicationRecord
  has_many :essay_topics, dependent: :destroy
  has_many :essays, through: :essay_topics

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    self.slug ||= title.to_s.parameterize if title.present?
  end
end

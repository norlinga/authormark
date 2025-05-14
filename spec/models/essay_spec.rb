# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Essay, type: :model do
  describe 'validations' do
    subject { build(:essay) }

    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_presence_of(:body) }
  end

  describe 'callbacks' do
    it 'generates a slug from title if missing' do
      essay = build(:essay, slug: nil, title: 'My Special Essay')
      essay.valid?
      expect(essay.slug).to eq('my-special-essay')
    end

    it 'does not overwrite an existing slug' do
      essay = build(:essay, slug: 'custom-slug')
      essay.valid?
      expect(essay.slug).to eq('custom-slug')
    end
  end

  describe 'scopes' do
    let!(:published_essay) { create(:essay, :published) }
    let!(:unpublished_essay) { create(:essay, :unpublished) }
    let!(:invisible_essay) { create(:essay, :invisible) }

    it '.visible returns only visible essays' do
      expect(Essay.visible).to include(published_essay)
      expect(Essay.visible).not_to include(invisible_essay)
    end

    it '.published returns only essays with a publication date' do
      expect(Essay.published).to include(published_essay)
      expect(Essay.published).not_to include(unpublished_essay)
    end

    it '.listable excludes system pages' do
      system = create(:essay, :system_about)
      normal = create(:essay)
      expect(Essay.listable).to include(normal)
      expect(Essay.listable).not_to include(system)
    end
  end

  describe 'system essays protection' do
    let!(:system_essay) { create(:essay, :system_about) }

    it 'prevents destroying system essays' do
      expect { system_essay.destroy }.not_to change { Essay.count }
      expect(system_essay.errors[:base]).to include('Cannot destroy system pages')
    end
  end

  describe 'first_published_at timestamp' do
    it 'sets first_published_at when becoming visible the first time' do
      essay = create(:essay, visible: false)
      expect(essay.first_published_at).to be_nil

      essay.update!(visible: true)
      expect(essay.first_published_at).not_to be_nil
    end

    it 'does not overwrite existing first_published_at on republish' do
      essay = create(:essay, visible: true, first_published_at: 2.days.ago)
      original_time = essay.first_published_at

      essay.update!(visible: false) # unpublish
      essay.update!(visible: true)  # re-publish

      expect(essay.first_published_at).to eq(original_time)
    end
  end
end

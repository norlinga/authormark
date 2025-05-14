# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EssayTopicPresenter do
  let(:essay) { create(:essay) }
  let(:topic) { create(:topic) }
  let(:view) do
    controller = ApplicationController.new
    controller.request = ActionDispatch::TestRequest.create
    controller.view_context
  end

  subject(:presenter) { described_class.new(essay: essay, topic: topic, view: view) }

  describe '#included?' do
    it 'returns true if the topic is included in the essay' do
      essay.topics << topic
      expect(presenter.included?).to be true
    end

    it 'returns false if the topic is not included' do
      expect(presenter.included?).to be false
    end
  end

  describe '#primary?' do
    it 'returns true if the topic is the primary topic' do
      essay.topics << topic
      essay.update!(primary_topic: topic)
      expect(presenter.primary?).to be true
    end

    it 'returns false otherwise' do
      expect(presenter.primary?).to be false
    end
  end

  describe '#title_class' do
    it 'includes green class if topic is included' do
      essay.topics << topic
      expect(presenter.title_class).to include('text-green-600')
    end

    it 'does not include green class otherwise' do
      expect(presenter.title_class).not_to include('text-green-600')
    end
  end

  describe '#promote_button' do
    context 'when topic is primary' do
      before do
        essay.topics << topic
        essay.update!(primary_topic: topic)
      end

      it 'renders the solid star icon' do
        expect(presenter.promote_button).to include('solid-star-icon')
      end
    end

    context 'when topic is not primary' do
      it 'renders the outline star icon button' do
        expect(presenter.promote_button).to include('button')
        expect(presenter.promote_button).to include('star-icon')
      end
    end
  end

  describe '#action_buttons' do
    context 'when topic is included' do
      before { essay.topics << topic }

      it 'returns remove and promote buttons' do
        html = presenter.action_buttons.join
        expect(html).to include('minus-circle-icon')
        expect(html).to include('star-icon')
      end
    end

    context 'when topic is not included' do
      it 'returns add and promote buttons' do
        html = presenter.action_buttons.join
        expect(html).to include('plus-circle-icon')
        expect(html).to include('star-icon')
      end
    end
  end
end

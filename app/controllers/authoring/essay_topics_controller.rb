# frozen_string_literal: true

module Authoring
  class EssayTopicsController < BaseController
    before_action :set_essay
    before_action :set_topics

    def create
      EssayTopicManager.new(@essay).add(@topic)
      render_panel
    end

    def destroy
      EssayTopicManager.new(@essay).remove(@topic)
      render_panel
    end

    def promote
      EssayTopicManager.new(@essay).promote(@topic)
      render_panel
    end

    private

    def set_essay
      @essay = Essay.find(params[:essay_id])
    end

    def set_topics
      @topics = Topic.all
      @topic = Topic.find(params[:topic_id])
    end

    def render_panel
      @all_topics = Topic.order(:title)
      render partial: "authoring/essays/topics", locals: { essay: @essay, all_topics: @all_topics }, formats: [ :html ]
    end
  end
end

# frozen_string_literal: true

class Authoring::TopicsController < Authoring::BaseController
  layout "authoring"

  def index
    @topic = Topic.new
    @topics = Topic.left_outer_joins(:essays)
                   .select("topics.*, COUNT(essay_topics.essay_id) AS essays_count")
                   .group("topics.id")
                   .order(:title)
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to authoring_topics_path, notice: "Topic added."
    else
      @topics = Topic.left_outer_joins(:essays)
                     .select("topics.*, COUNT(essay_topics.essay_id) AS essays_count")
                     .group("topics.id")
                     .order(:title)
      render :index
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to authoring_topics_path, notice: "Topic removed." }
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("topic_#{@topic.id}")
      end
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title)
  end
end

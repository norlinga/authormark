# frozen_string_literal: true

class Authoring::EssaysController < Authoring::BaseController
  layout "authoring"

  def index
    @system_essays = Essay.system_pages.order(:system_slug)
    @user_essays   = Essay.listable.order(created_at: :desc)
    @new_essay     = Essay.new
  end

  def create
    @essay = Essay.new(essay_params)
    @essay.body = "Write something here..." if @essay.body.blank?

    if @essay.save
      redirect_to edit_authoring_essay_path(@essay), notice: "Essay created."
    else
      redirect_to authoring_essays_path, alert: "Essay could not be created."
    end
  end

  def edit
    @topics = Topic.all
    @essay = Essay.find(params[:id])
  end

  def update
    @essay = Essay.find(params[:id])

    if @essay.update(essay_params)
      redirect_to authoring_essays_path, notice: "Essay updated successfully."
    else
      @topics = Topic.all
      render :edit
    end
  end

  def destroy
    @essay = Essay.find(params[:id])
    @essay.destroy
    redirect_to authoring_essays_path, notice: "Essay deleted."
  end

  private

  def essay_params
    params.require(:essay).permit(:title, :slug, :system_slug, :body, :first_published_at, :visible)
  end
end

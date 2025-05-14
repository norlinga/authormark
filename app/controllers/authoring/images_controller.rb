# frozen_string_literal: true

module Authoring
  class ImagesController < BaseController
    layout "authoring"

    def create
      image = SiteImage.new
      image.image.attach(params[:image])
      image.save!
      redirect_to authoring_images_path, notice: "Image uploaded"
    end

    def index
      @images = SiteImage.with_attached_image.order(created_at: :desc)
    end

    def destroy
      image = SiteImage.find(params[:id])
      image.image.purge
      image.destroy
      redirect_to authoring_images_path, notice: "Image deleted"
    end
  end
end

# frozen_string_literal: true

# app/controllers/authoring/settings_controller.rb
class Authoring::SettingsController < Authoring::BaseController
  layout "authoring"

  def edit
    @site_title = SiteSetting["site_title"]
    @copyright_text = SiteSetting["copyright_text"]
    @header_content = SiteSetting["header_content"]
  end

  def update
    SiteSetting["site_title"] = params[:site_title]
    SiteSetting["copyright_text"] = params[:copyright_text]
    SiteSetting["header_content"] = params[:header_content]

    redirect_to edit_authoring_settings_path, notice: "Settings saved."
  end
end

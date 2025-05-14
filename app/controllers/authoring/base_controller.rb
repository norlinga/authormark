# app/controllers/authoring/base_controller.rb
class Authoring::BaseController < ApplicationController
  before_action :authenticate_author!

  private

  def authenticate_author!
    expected_username = Rails.application.credentials.dig(:authoring, :username)
    expected_password = Rails.application.credentials.dig(:authoring, :password)

    authenticate_or_request_with_http_basic("Authoring") do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username, expected_username) &
      ActiveSupport::SecurityUtils.secure_compare(password, expected_password)
    end
  end
end

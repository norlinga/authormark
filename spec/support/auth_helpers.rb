# frozen_string_literal: true

module AuthHelpers
  def basic_auth_headers(username = nil, password = nil)
    username ||= Rails.application.credentials.dig(:authoring, :username)
    password ||= Rails.application.credentials.dig(:authoring, :password)

    {
      "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    }
  end
end

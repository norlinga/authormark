require "rails_helper"

RSpec.describe "Authoring::Essays", type: :request do
  include AuthHelpers

  it "allows access with correct credentials" do
    get authoring_essays_path, headers: basic_auth_headers # comes from AuthHelpers
    expect(response).to be_successful
  end

  it "denies access without credentials" do
    get authoring_essays_path
    expect(response).to have_http_status(:unauthorized)
  end
end

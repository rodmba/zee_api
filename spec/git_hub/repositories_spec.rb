# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /api/v1/git_hub/repositories", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:sign_in_url) { "/api/v1/users/sign_in" }
  let(:sign_in_params) do
    {
      email: user.email,
      password: user.password
    }
  end
  let(:public_repositories_url) { "/api/v1/git_hub/repositories" }

  before { sign_in }

  context "list public repositories" do
    before do
      get public_repositories_url, headers: auth_header(response)
    end

    it "returns 200" do
      expect(response).to have_http_status(200)
    end

    it "returns sanitized repository attributes" do
      repo = JSON.parse(response.body).last.symbolize_keys

      expect(repo).to have_key(:full_name)
      expect(repo).to have_key(:description)
      expect(repo).to have_key(:stargazers_count)
      expect(repo).to have_key(:owner)
      expect(repo).to have_key(:language)
    end
  end

  def sign_in
    post sign_in_url, params: sign_in_params
  end

  def auth_header(res)
    token = JSON.parse(res.body)["auth_token"]
    { "Authorization": "Bearer #{token}" }
  end
end

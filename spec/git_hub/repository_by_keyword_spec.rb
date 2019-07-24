# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /api/v1/git_hub/repository_by_keyword", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:sign_in_url) { "/api/v1/users/sign_in" }
  let(:sign_in_params) do
    {
      email: user.email,
      password: user.password
    }
  end
  let(:search_repository_url) { "/api/v1/git_hub/repository_by_keyword" }

  before { sign_in }

  context "searchs repositories by keyword" do
    let(:params) { { keyword: "github" } }

    before do
      get search_repository_url, params: params, headers: auth_header(response)
    end

    it "returns 200" do
      expect(response).to have_http_status(200)
    end
  end

  context "searchs repositories by language" do
    let(:params) { { language: "python" } }

    before do
      get search_repository_url, params: params, headers: auth_header(response)
    end

    it "returns 200" do
      expect(response).to have_http_status(200)
    end

    it "returns a repository filtered by language" do
      repository = JSON.parse(response.body).last.symbolize_keys
      expect(repository[:language]).to eq(params[:language].capitalize)
    end
  end

  context "list default repositories" do
    before do
      get search_repository_url, headers: auth_header(response)
    end

    it "returns 200" do
      expect(response).to have_http_status(200)
    end

    it "returns ruby repositories by default" do
      repository = JSON.parse(response.body).last.symbolize_keys
      expect(repository[:language]).to eq("Ruby")
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

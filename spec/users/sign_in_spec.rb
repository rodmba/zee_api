# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /api/v1/users/sign_in", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:url) { "/api/v1/users/sign_in" }
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  context "when params are correct" do
    before do
      post url, params: params
    end

    it "returns 200" do
      expect(response).to have_http_status(200)
    end

    it "returns JWT token" do
      auth_token = JSON.parse(response.body)["auth_token"]
      expect(auth_token).to be_present
    end
  end

  context "when login params are incorrect" do
    before { post url }

    it "returns unathorized status" do
      expect(response.status).to eq 401
    end
  end
end

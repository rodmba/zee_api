# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /api/v1/users", type: :request do
  let(:url) { "/api/v1/users" }
  let(:params) do
    {
      user: {
        email: "person@example.com",
        password: "password"
      }
    }
  end

  context "when user is unauthenticated" do
    before { post url, params: params }

    it "returns 200" do
      expect(response.status).to eq 201
    end

    it "returns a new user" do
      res = JSON.parse(response.body)
      expect(res["status"]).to eq("User created successfully")
    end
  end

  context "when user already exists" do
    before do
      FactoryBot.create(:user, email: params[:user][:email])

      post url, params: params
    end

    it "returns bad request status" do
      expect(response.status).to eq 400
    end
  end
end

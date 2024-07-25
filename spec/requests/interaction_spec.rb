require 'rails_helper'

RSpec.describe "Interactions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/interaction/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/interaction/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/interaction/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end

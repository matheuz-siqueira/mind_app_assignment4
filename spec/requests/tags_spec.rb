require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/tags/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/tags/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/tags/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

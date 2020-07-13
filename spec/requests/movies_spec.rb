require 'rails_helper'

RSpec.describe "Movies", type: :request do
  let!(:user) { create(:user, full_name: "Test User", email: "testuser@gmail.com", password: '123456') }
  let!(:movie) { create(:movie, title: "Movie test1", plot: "test plot")}
  before do
    stub_current_user(user)
  end

  describe "GET /api/v1/movies" do
    it "Return movies list orderd by creation date" do
      get "/api/v1/movies"

      expect(response).to have_http_status(200)
      expect(json.first['title']).to eq(movie.title)
    end
  end
end

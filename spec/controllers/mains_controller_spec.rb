require 'rails_helper'

RSpec.describe MainsController, type: :controller do

  describe "GET #top" do
    it "returns http success" do
      skip("Until implement devise to rspec")
      get :top
      expect(response).to have_http_status(:success)
    end
  end

end

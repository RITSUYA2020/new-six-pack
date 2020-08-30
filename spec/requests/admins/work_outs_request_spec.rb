require 'rails_helper'

RSpec.describe "Admins::WorkOuts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admins/work_outs/index"
      expect(response).to have_http_status(:success)
    end
  end

end

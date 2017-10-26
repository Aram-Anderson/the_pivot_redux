require 'rails_helper'

RSpec.describe PlatformAdminController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      plat_admin = create(:user, platform_admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plat_admin)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'
RSpec.describe SecretsController, type: :controller do
  before do
    @user = create(:user)
    @secret = create(:secret, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access create" do
      get :create
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      get :destroy, params: {id: @secret}
      expect(response).to redirect_to("/sessions/new")
    end
  end
  context "when signed in as the wrong user" do
    before do
      @user2 = User.create(name: "Test2", email: "test2@tes.com", password: "password")
      session[:user_id] = @user2.id
    end
    it "cannot destroy another user's secret" do
      get :destroy, params: {id: @secret}
      expect(response).to redirect_to("/users/#{session[:user_id]}")
    end
  end
end

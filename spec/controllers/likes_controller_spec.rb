require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before do
    @user = create(:user)
    @secret = create(:secret, user: @user)
    @like = create(:like, secret: @secret, user: @user)
  end
  context "when not logged in " do
    before do
      session[:user_id] = nil
    end
    it "cannot create a like" do
      get :create, params: {user: @user, secret: @secret}
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot destroy a like" do
      get :destroy, params: {id: @like}
      expect(response).to redirect_to("/sessions/new")
    end
  end
  context "when signed in as the wrong user" do
    before do
      @user2 = User.create(name: "Test2", email: "test2@tes.com", password: "password")
      session[:user_id] = @user2.id
    end
    it "shouldn't be able to destroy a like" do
      get :destroy, params: {id: @like}
      expect(response).to redirect_to("/secrets")
    end
  end
end

require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
    @user2 = User.create(name: "Test2", email: "test2@tes.com", password: "password")
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access edit" do
      get :edit, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end

    it "cannot access update" do
      get :update, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      get :destroy, params: {id: @user.id}
      expect(response).to redirect_to("/sessions/new")
    end
  end
  context "when signed in as the wrong user" do
    before do
      session[:user_id] = @user2.id
    end
    it "cannot access profile page another user" do
      get :show, params: {id: @user.id}
      expect(response).to redirect_to("/users/#{session[:user_id]}")
    end
    it "cannot access the edit page of another user" do
      get :edit, params: {id: @user.id}
      expect(response).to redirect_to("/users/#{session[:user_id]}")
    end
    it "cannot update another user" do
      get :update, params: {id: @user.id}
      expect(response).to redirect_to("/users/#{session[:user_id]}")
    end
    it "cannot destroy another user" do
      get :destroy, params: {id: @user.id}
      expect(response).to redirect_to("/users/#{session[:user_id]}")
    end
  end
end

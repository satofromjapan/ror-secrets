require 'rails_helper'
RSpec.describe User do
  # ...
  context 'relationships' do
    before do
      @user = create(:user)
      @secret = create(:secret, content: 'secret 1', user: @user)
      @like = create(:like, secret: @secret, user: @user)
    end
    it 'has secrets' do
      expect(@user.secrets).to include(@secret)
    end
    it 'has likes' do
      expect(@user.likes).to include(@like)
    end
    it "has secrets through likes table" do
      expect(@user.secrets_liked).to include(@secret)
    end
  end
end

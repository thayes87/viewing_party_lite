require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_viewing_parties) }
    it { should have_many(:viewing_parties).through(:user_viewing_parties) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe 'valid password' do
    it 'does not show the users password when called' do
      user = User.create(name: "meg", email:"meg@test.com", password: "test123", password_confirmation: "test123")
      
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end
end
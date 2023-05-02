require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:oauth_providers).dependent(:destroy) }  
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe 'callss FindForOauthService' do
    let!(:customer) { create(:customer) }
    let(:auth)      { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }
    let(:service)   { double('FindForOauthService') }

    it 'calls FindForOauthService' do
      expect(FindForOauthService).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      Customer.find_for_oauth(auth)
    end
  end
end

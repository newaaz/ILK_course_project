require 'rails_helper'

RSpec.describe FindForOauthService do
  let!(:customer) { create(:customer) }
  let(:auth)      { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }
  subject         { FindForOauthService.new(auth) }

  context 'customer already has authorization' do
    it 'returns the customer' do
      customer.oauth_providers.create(provider: 'github', uid: '123456')

      expect(subject.call).to eq customer
    end
  end

  context 'customer has not oauth_providers' do
    context 'customer already exists' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: customer.email }) }

      it 'does not create new customer' do
        expect { subject.call }.to_not change(Customer, :count)
      end

      it 'creates oauth_provider for customer' do
        expect { subject.call }.to change(customer.oauth_providers, :count).by(1)
      end

      it 'creates oauth_provider with correct provider and uid' do
        oauth_provider = subject.call.oauth_providers.first

        expect(oauth_provider.provider).to eq auth.provider
        expect(oauth_provider.uid).to eq auth.uid
      end

      it 'returns the customer' do
        expect(subject.call).to eq customer
      end
    end

    context 'customer does not exist and receive oauth_provider with email' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'new@customer.com' }) }

      it 'creates new customer' do
        expect { subject.call }.to change(Customer, :count).by(1)
      end

      it 'returns new customer' do
        expect(subject.call).to be_a(Customer)
      end

      it 'fills customer email' do
        customer = subject.call
        expect(customer.email).to eq 'new@customer.com'
      end

      it 'create oauth_provider for customer' do 
        customer = subject.call
        expect(customer.oauth_providers).to_not be_empty
      end

      it 'create oauth_provider with correct provider and uid' do
        oauth_provider = subject.call.oauth_providers.first

        expect(oauth_provider.provider).to eq auth.provider
        expect(oauth_provider.uid).to eq auth.uid
      end
    end

    context 'customer does not exist and receive oauth_provider without email' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: '123456', info: { email: nil }) }

      it 'does not create new customer' do
        expect { subject.call }.to_not change(Customer, :count)
      end

      it 'returns new customer' do
        expect(subject.call).to be_a_new(Customer)
      end
    end
  end
end

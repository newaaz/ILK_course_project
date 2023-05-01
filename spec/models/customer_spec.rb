require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }    
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe '.find_for_oauth' do
    let!(:customer) { create(:customer) }
    let(:auth)      { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }

    context 'customer already has authorization' do
      it 'returns the customer' do
        customer.oauth_providers.create(provider: 'github', uid: '123456')
        expect(Customer.find_for_oauth(auth)).to eq customer
      end
    end

    context 'customer has not authorization by oauth provider' do    
      context 'customer already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: customer.email }) }
        it 'does not create new customer' do
          expect { Customer.find_for_oauth(auth) }.to_not change(Customer, :count)        
        end

        it 'creates oauth provider for customer' do
          expect { Customer.find_for_oauth(auth) }.to change(customer.oauth_providers, :count).by(1)
        end

        it 'creates oauth provider with provider and uid' do
          oauth_provider = Customer.find_for_oauth(auth).oauth_providers.first

          expect(oauth_provider.provider).to eq auth.provider
          expect(oauth_provider.uid).to eq auth.uid
        end

        it 'returns the customer' do
          expect(Customer.find_for_oauth(auth)).to eq customer
        end
      end    
    end

    context 'customer does not exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'newuser@user.com' }) }

      it 'creates new customer' do
        expect { Customer.find_for_oauth(auth) }.to change(Customer, :count).by(1)
      end

      it 'returns new customer' do
        expect(Customer.find_for_oauth(auth)).to be_a(Customer)
      end

      it 'fills customer email' do
        customer = Customer.find_for_oauth(auth)
        expect(customer.email).to eq auth.info.email
      end

      it 'creates oauth provider for new customer' do
        customer = Customer.find_for_oauth(auth)
        expect(customer.oauth_providers).to_not be_empty
      end

      it 'creates oauth provider with provider and uid' do
        oauth_provider = Customer.find_for_oauth(auth).oauth_providers.first
        
        expect(oauth_provider.provider).to eq auth.provider
        expect(oauth_provider.uid).to eq auth.uid
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Customers::CustomersController, type: :controller do
  let(:customer) { create(:customer) }

  describe 'GET #new_customer' do
    before { get :new }

    it 'assigns a new customer to @customer' do
      expect(assigns(:customer)).to be_a_new(Customer)
    end   

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create_customer' do

    before do
      session[:oauth_provider] = 'github'
      session[:oauth_uid] = '123'
    end

    context 'with valid email' do
      it 'send_confirmation_instructions' do
        post :create, params: { customer: { email: 'new@customer.com' } }
        mail = find_mail_to('new@customer.com')
        expect(mail.subject).to eq 'Confirmation instructions'
      end

      it 'saves a new customer in the DB' do
        expect { post :create, params: { customer: { email: 'new@customer.com' } } }.to change(Customer, :count).by(1)
      end

      it 'redirect to root path' do
        post :create, params: { customer: { email: 'new@customer.com' } }
        expect(response).to redirect_to root_path
      end

      it 'create customer with correct email' do
        post :create, params: { customer: { email: 'new@customer.com' } }
        expect(Customer.last.email).to eq 'new@customer.com'
      end

      it 'create correct oauth_provider' do
        post :create, params: { customer: { email: 'new@customer.com' } }
        expect(Customer.last.oauth_providers.first.provider).to eq 'github'
        expect(Customer.last.oauth_providers.first.uid).to eq '123'
      end
    end

    context 'with invalid email' do
      it 'does not save the customer in the DB' do
        expect { post :create, params: { customer: { email: '' } } }.to_not change(Customer, :count)
      end

      it 're-renders new view' do
        post :create, params: { customer: { email: '' } }
        expect(response).to render_template :new
      end
    end
  end

  def find_mail_to(email)
    ActionMailer::Base.deliveries.find { |mail| mail.to.include?(email) }
  end
end

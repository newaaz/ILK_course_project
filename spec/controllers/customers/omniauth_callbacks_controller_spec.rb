require 'rails_helper'

RSpec.describe Customers::OmniauthCallbacksController, type: :controller do 

  before { @request.env['devise.mapping'] = Devise.mappings[:customer] }

  # describe 'Github' do
  #   let(:oauth_data)  { { 'provider' => 'github', 'uid' => '123' } }

  #   it 'find customer from oauth data' do
  #     allow(request.env).to receive(:[]).and_call_original
  #     allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)

  #     expect(Customer).to receive(:find_for_oauth).with(oauth_data)
  #     get :github
  #   end

  #   context 'customer exists' do
  #     let!(:customer) { create(:customer) }

  #     before  do
  #       allow(Customer).to receive(:find_for_oauth).and_return(customer)
  #       get :github
  #     end

  #     it 'login customer if exists' do
  #       expect(subject.current_customer).to eq customer
  #     end

  #     it 'redirect to root path' do
  #       expect(response).to redirect_to root_path
  #     end
  #   end

  #   context 'customer does not exist' do
  #     before do
  #       allow(Customer).to receive(:find_for_oauth).and_return(nil)
  #       get :github
  #     end

  #     it 'redirect to root path' do
  #       expect(response).to redirect_to root_path
  #     end    

  #     it 'does not login customer' do
  #       expect(subject.current_customer).to_not be
  #     end
  #   end
    
  # end
  
  describe 'sign_in_with_provider' do
    let(:oauth_data)  { mock_auth_hash(:github, 'customer@email.com') }
    #let(:oauth_data)  { { 'provider' => 'github', 'uid' => '123' } }

    before { @request.env['omniauth.auth'] = :oauth_data }

    it 'finds customer from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      expect(Customer).to receive(:find_for_oauth).with(oauth_data)
      get :github
    end

    context 'customer exists (provider with email)' do
      let!(:customer) { create(:customer) } 

      before do
        allow(Customer).to receive(:find_for_oauth).and_return(customer)
        get :github
      end

      it 'login customer' do
        expect(subject.current_customer).to eq customer
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
    
    context 'customer empty (provider without email)' do
      let(:oauth_data)  { mock_auth_hash(:vkontakte) }

      before do
        @request.env['omniauth.auth'] = :oauth_data

        allow(Customer).to receive(:find_for_oauth)
        get :vkontakte
      end

      it 'redirects to ask email path if provider without email' do  
        expect(response).to redirect_to customers_new_customer_path
      end

      it 'does not login customer' do     
        expect(subject.current_customer).to_not be
      end

      it 'set correct session keys' do
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
        expect(Customer).to receive(:find_for_oauth).with(oauth_data)
        get :vkontakte

        expect(session[:oauth_provider]).to eq 'vkontakte'
        expect(session[:oauth_uid]).to eq '123456'
      end
    end
  end
end

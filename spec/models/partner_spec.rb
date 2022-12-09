require 'rails_helper'

RSpec.describe Partner, type: :model do
  describe 'associations' do
    it { should have_many(:properties).dependent(:destroy) }    
  end
  
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
end

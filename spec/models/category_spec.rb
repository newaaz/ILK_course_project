require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:properties).dependent(:destroy) }    
  end
  
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :ordinal_number }
  end
end

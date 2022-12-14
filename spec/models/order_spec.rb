require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:property) }
    it { should belong_to(:room) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :check_in }
    it { should validate_presence_of :check_out }
  end
end

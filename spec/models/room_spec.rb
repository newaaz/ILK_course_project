require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { should belong_to(:property) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :guest_base_count }
    it { should validate_presence_of :guest_max_count }
  end
end

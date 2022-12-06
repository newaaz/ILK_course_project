require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { should belong_to(:property) }

    it { should have_many(:prices).dependent(:destroy) } 

    it { should accept_nested_attributes_for :prices }
  end
  
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :guest_base_count }
    it { should validate_presence_of :guest_max_count }
  end
end

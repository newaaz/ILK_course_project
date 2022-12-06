require 'rails_helper'

RSpec.describe Price, type: :model do
  describe 'associations' do
    it { should belong_to(:room) }
  end

  describe 'validations' do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :day_cost }
  end
end

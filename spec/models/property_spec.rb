require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'associations' do
    it { should belong_to(:owner) }
    it { should belong_to(:category) } 
    it { should belong_to(:town) }

    it { should have_many(:rooms).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }  

    it_behaves_like 'Imagable'
  end
  
  describe 'validations' do
    it { should validate_presence_of :title }
  end
end

require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  describe 'associations' do
    it { should belong_to(:geolocable) }
  end

  describe 'validations' do
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
  end
end

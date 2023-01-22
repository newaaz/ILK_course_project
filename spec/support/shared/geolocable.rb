shared_examples_for 'Geolocable' do
  it { should have_one(:geolocation).dependent(:destroy) }
  it { should accept_nested_attributes_for :geolocation }
end

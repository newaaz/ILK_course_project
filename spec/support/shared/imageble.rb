shared_examples_for 'Imagable' do
  it 'have one attached avatar' do
    expect(subject.class.new.avatar).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  it 'have many attached images' do
    expect(subject.class.new.images).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end

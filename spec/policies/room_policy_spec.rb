require 'rails_helper'

describe RoomPolicy do

  subject { described_class.new(user, room) }

  let(:owner)     { create(:partner) }
  let(:non_owner) { create(:partner) }
  let(:property)  { create(:property, owner: owner) }
  let(:room)      { build(:room, property: property) }

  context 'for a visitor' do
    let(:user)  { nil }

    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'for a property owner' do
    let(:user)  { owner }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'for a property non-owner' do
    let(:user)  { non_owner }

    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end
end


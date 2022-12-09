require 'rails_helper'

describe PropertyPolicy do

  subject { described_class.new(user, property) }

  let(:owner)     { create(:partner) }
  let(:non_owner) { create(:partner) }
  let(:property)  { create(:property, owner: owner) }

  context 'for a visitor' do
    let(:user)  { nil }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }

    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'for a owner property' do
    let(:user)  { owner }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'for a non-owner property' do
    let(:user)  { non_owner }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end
end


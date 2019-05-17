require 'rails_helper'

RSpec.describe Target, type: :model do
  context 'when is a valid instance' do
    subject { build(:target) }
    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end

  context 'validations' do
    subject { build(:target) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:topic) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:topic) }
  end

  context 'when the user has created 10 targets' do
    let(:user) { create(:user) }
    before { create_list(:target, 10, user: user) }
    it 'doesnt save any new target for the user' do
      expect(build(:target, user: user).save).to eq false
    end
  end
end

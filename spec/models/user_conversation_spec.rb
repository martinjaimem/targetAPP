require 'rails_helper'

RSpec.describe UserConversation, type: :model do
  context 'is a valid instance' do
    subject { build(:user_conversation) }

    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end

  context 'validations ' do
    it { is_expected.to belong_to(:conversation) }
    it { is_expected.to belong_to(:user) }
  end
end

# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:users) { create_list(:user, 3) }
  let(:conversation) { build(:conversation) }

  context 'is a valid instance' do
    subject { conversation }

    it 'saves correctly' do
      subject.users << users[0...1]
      subject.save!
      is_expected.to be_valid
    end
  end

  context 'validate users qty' do
    subject { conversation.errors[:users] }

    it 'does not save an instance with #users gt 2' do
      conversation.users << users
      conversation.valid?
      is_expected.to include(I18n.t('api.conversation.user_validation.errors.length', number: 3))
    end
  end

  context 'validate different users' do
    subject { conversation.errors[:users] }

    it 'does not save an instance with the same 2 users' do
      conversation.users << users[0]
      conversation.users << users[0]
      conversation.valid?
      is_expected.to include(I18n.t('api.conversation.user_validation.errors.different'))
    end
  end
end

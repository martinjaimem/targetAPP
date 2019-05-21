# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  text            :string           not null
#  user_id         :bigint
#  conversation_id :bigint
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'is a valid instance' do
    subject { build(:message) }

    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end

  context 'validations' do
    subject { build(:message) }

    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:conversation) }
  end
end

require 'rails_helper'

describe ReadMessagesJob, type: :job do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_conversation) { create(:conversation, users: [user, other_user]) }
  let(:other_conversation) { create(:conversation) }
  let!(:other_user_messages) do
    create_list(
      :message,
      10,
      user: other_user,
      conversation: user_conversation,
      read: true
    )
  end
  let!(:unread_other_user_messages) do
    create_list(
      :message,
      10,
      user: other_user,
      conversation: user_conversation,
      read: false
    )
  end
  let!(:unread_user_messages) do
    create_list(
      :message,
      5,
      user: user,
      conversation: user_conversation,
      read: false
    )
  end

  describe '#perform' do
    before(:each) { ActiveJob::Base.queue_adapter = :test }

    it 'broadcasts the message to the conversation' do
      ReadMessagesJob.perform_now(user_conversation, user)
      expect(Message.where(conversation_id: user_conversation[:id], read: false).count).to be(5)
    end
  end
end

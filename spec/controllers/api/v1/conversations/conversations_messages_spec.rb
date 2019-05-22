require 'rails_helper'

describe 'POST /api/v1/conversations/{conversation_id}/messages', type: :request do
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
      conversation:
      user_conversation,
      read: false
    )
  end
  let!(:unread_user_messages) do
    create_list(
      :message,
      10,
      user: user,
      conversation:
      user_conversation,
      read: false
    )
  end

  context 'when the user who is not in the conversation is logged in' do
    sign_in(:other_user)
    it 'does not provide the user with those messages' do
      expect { get api_v1_conversation_messages_path(other_conversation[:id]) }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when the user who is in the conversation is logged in' do
    sign_in(:user)
    it 'returns only the messages of the conversation' do
      get api_v1_conversation_messages_path(user_conversation[:id])
      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(response_body['messages'].length).to be(20)
      expect(response_body['messages'][0].keys).to contain_exactly(
        'id', 'read', 'user_id', 'created_at', 'text'
      )
    end
  end

  context 'when the user is not logged in' do
    it 'responds with unauthorized' do
      get api_v1_conversation_messages_path(user_conversation[:id])
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

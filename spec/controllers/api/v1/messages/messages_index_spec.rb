require 'rails_helper'

describe 'GET /api/v1/messages', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:conversation) { create(:conversation, users: [user, other_user]) }
  let!(:user_messages) { create_list(:message, 10, user: user, conversation: conversation) }
  let!(:other_conversations) { create_list(:conversation, 5) }
  let!(:other_messages) { create_list(:message, 10, conversation: other_conversations[0]) }

  context 'when the user is logged in' do
    sign_in(:user)
    it 'returns all and only the messages for the conversation' do
      get api_v1_conversation_messages_path(conversation[:id])
      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(response_body['messages'].length).to be(10)
      expect(response_body['messages'][0].keys).to contain_exactly(
        'id', 'read', 'user_id', 'created_at'
      )
    end
  end

  context 'when the user is not logged in' do
    it 'responds with unauthorized' do
      get api_v1_conversation_messages_path(conversation[:id])
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

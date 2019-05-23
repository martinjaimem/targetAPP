require 'rails_helper'

describe 'GET /api/v1/conversations', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_conversations) { create_list(:conversation, 2, users: [user, other_user]) }
  let!(:user_messages) do
    create_list(
      :message,
      10,
      user: user,
      conversation: user_conversations[0],
      read: true
    )
  end
  let!(:unread_user_messages) do
    create_list(
      :message,
      10,
      user: user,
      conversation: user_conversations[1],
      read: false
    )
  end
  let!(:other_conversations) { create_list(:conversation, 5) }
  let!(:other_messages) { create_list(:message, 10, conversation: other_conversations[0]) }

  context 'when the user is logged in' do
    sign_in(:user)
    it 'returns all and only the conversations ids with unread messages' do
      params = {
        has_unread_messages: true
      }
      get api_v1_conversations_path, params: params
      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(response_body['conversations'].length).to be(1)
      expect(response_body['conversations'][0].keys).to contain_exactly('id', 'users')
      expect(response_body['conversations'][0]['id']).to be(user_conversations[1][:id])
    end

    it 'returns only the conversations of the user' do
      get api_v1_conversations_path
      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(response_body['conversations'].length).to be(2)
    end
  end

  context 'when the user is not logged in' do
    it 'responds with unauthorized' do
      get api_v1_conversations_path
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

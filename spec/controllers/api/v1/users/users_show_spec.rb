require 'rails_helper'

describe 'GET /api/v1/users/{id}', type: :request do
  let(:user) { create :user }
  let!(:other_users) { create_list(:user, 10) }

  context 'when the user is logged in' do
    sign_in(:user)

    it 'has 200 status code' do
      get api_v1_targets_path
      expect(response).to have_http_status(:success)
    end

    it 'returns the user profile' do
      get api_v1_user_path(other_users[0][:id])
      response_body = JSON.parse(response.body)
      expect(response_body.keys).to contain_exactly(
        'created_at', 'email', 'first_name', 'gender', 'id', 'name', 'updated_at', 'username'
      )
      expect(response_body['id']).to eq(other_users[0][:id])
    end
  end

  context 'when the user is not logged in' do
    it 'should respond with unauthorized' do
      get api_v1_user_path(other_users[0][:id])
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

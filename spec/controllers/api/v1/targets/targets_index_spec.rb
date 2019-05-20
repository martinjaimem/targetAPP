require 'rails_helper'

describe 'GET /api/v1/targets', type: :request do
  let(:user) { create :user }
  let!(:target_of_the_user) { create_list(:target, 10, user: user) }
  let!(:other_target) { create_list(:target, 5) }

  context 'when the user is logged in' do
    sign_in(:user)

    it 'has 200 status code' do
      get api_v1_targets_path
      expect(response).to have_http_status(:success)
    end

    it 'returns all and only the targets for the user' do
      get api_v1_targets_path
      response_body = JSON.parse(response.body)
      expect(response_body['targets'].length).to be(10)
      expect(response_body['targets'][0].keys).to contain_exactly(
        'id', 'lat', 'lng', 'title', 'topic_id', 'user_id'
      )
    end
  end

  context 'when the user is not logged in' do
    it 'should respond with unauthorized' do
      get api_v1_targets_path
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

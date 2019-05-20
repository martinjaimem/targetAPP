require 'rails_helper'

describe 'POST /api/v1/targets', type: :request do
  let(:user) { create :user }
  let(:topic) { create(:topic) }

  context 'when the user is logged in' do
    sign_in(:user)

    it 'creates a target successfully' do
      params = {
        target: {
          name: 'Target name',
          lat: 98.898,
          lng: 34.989,
          radius: 99.999,
          topic_id: topic[:id],
          title: 'Target Title'
        }
      }
      post api_v1_targets_path, params: params
      expect(response).to have_http_status(:success)
    end
  end

  context 'when the user is not logged in' do
    it 'should respond with unauthorized' do
      params = {
        target: {
          name: 'Target name',
          lat: 98.898,
          lng: 34.989,
          radius: 99.999,
          topic_id: topic[:id],
          title: 'Target Title'
        }
      }
      post api_v1_targets_path, params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

require 'rails_helper'
RSpec.describe 'POST /api/v1/targets', type: :request do
  let(:user) { create :user }
  let(:topic) { create(:topic) }
  describe 'the user is logged in' do
    sign_in(:user)
    it 'creates successfully a target' do
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
      post '/api/v1/targets', params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'the user is not logged in' do
    it 'should respond with unauthorized' do
      get '/api/v1/targets'
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

RSpec.describe 'GET /api/v1/targets', type: :request do
  let(:user) { create :user }
  describe 'the user is logged in' do
    sign_in(:user)
    it 'has 200 status code' do
      get '/api/v1/targets'
      expect(response).to have_http_status(:success)
    end
    it 'returns all the targets for the user' do
      create_list(:target, 10, user: user)
      get '/api/v1/targets'
      response_body = JSON.parse(response.body)
      expect(response_body['targets'].length).to be(10)
      expect(response_body['targets'][0].keys).to contain_exactly(
        'id', 'lat', 'lng', 'title', 'topic_id', 'user_id'
      )
    end
    it 'returns only the targets for the user' do
      create(:target)
      get '/api/v1/targets'
      response_body = JSON.parse(response.body)
      expect(response_body['targets'].length).to be(0)
    end
  end

  describe 'the user is not logged in' do
    it 'should respond with unauthorized' do
      get '/api/v1/targets'
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

require 'rails_helper'

RSpec.describe 'POST /api/v1/questions', type: :request do
  let(:user) { create :user }

  context 'when the user is logged in' do
    sign_in(:user)
    it 'has 204 status code (sends email)' do
      params = {
        "subject": 'email_subject',
        "body": 'email_body'
      }
      post api_v1_questions_path, params: params
      expect(response).to have_http_status(204)
    end
  end

  context 'when the user is not logged in' do
    it 'responds with unauthorized (doesnt send email)' do
      post api_v1_questions_path
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

require 'rails_helper'
RSpec.describe 'POST /api/v1/questions', type: :request do
  let(:user) { create :user }
  describe 'the user is logged in' do
    sign_in(:user)
    it 'has 204 status code (sends email)' do
      post '/api/v1/questions'
      expect(response).to have_http_status(204)
    end
  end

  describe 'the user is not logged in' do
    it 'should respond with unauthorized (doesnt send email)' do
      post '/api/v1/questions'
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

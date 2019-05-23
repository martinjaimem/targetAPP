require 'rails_helper'

describe 'PUT /api/v1/users/:id', type: :request do
  let(:user) { create(:user, username: 'old_username') }
  subject do
    put api_v1_user_path(user[:id]), params: {
      user: {
        username: 'new_username'
      }
    }
  end
  context 'when the user is logged in' do
    sign_in(:user)

    it 'edits a user successfully' do
      subject
      expect(User.find(user[:id])[:username]).to eq('new_username')
    end
  end

  context 'when the user is not logged in' do
    it 'should respond with unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
      expect(User.find(user[:id])[:username]).not_to eq('new_username')
    end
  end
end

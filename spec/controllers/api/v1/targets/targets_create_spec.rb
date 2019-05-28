require 'rails_helper'

describe 'POST /api/v1/targets', type: :request do
  let(:user) { create :user }
  let(:topic) { create(:topic) }
  let!(:compatible_target) do
    create(:target, lat: 50, lng: 50, topic: topic, radius: 4000)
  end
  let!(:other_target_not_near) { create(:target, topic: topic, lat: 0, lng: 0, radius: 50) }
  let!(:other_target_other_topic) { create(:target, lat: 49, lng: 49, radius: 5000) }

  context 'when the user is logged in' do
    sign_in(:user)

    it 'creates a target successfully' do
      params = {
        target: {
          name: 'Target name',
          lat: 1,
          lng: 1,
          radius: 3,
          topic_id: topic[:id],
          title: 'Target Title'
        }
      }
      post api_v1_targets_path, params: params
      expect(response).to have_http_status(:success)
    end

    context 'matches several targets' do
      subject do
        post api_v1_targets_path, params: { target: {
          title: 'New Target',
          radius: 3000,
          topic_id: topic[:id],
          lat: 45,
          lng: 45
        } }
      end

      it 'notifies the users that matched with the target' do
        allow(NotificationsService).to receive(:notify).once.and_call_original
        subject
        expect(NotificationsService).to have_received(:notify).with(
          [compatible_target.user.push_token],
          I18n.t('api.targets.notification.match'),
          username: compatible_target.user.username
        )
      end

      it 'responds with the conversations of matched targets users' do
        subject
        response_body = json
        expect(response_body['conversations'].length).to be(1)
        expect(response_body['conversations'][0].keys).to contain_exactly(
          'id', 'users'
        )
        users_of_first_conversation = response_body['conversations'][0]['users']
        expect(users_of_first_conversation.length).to be(2)
        expect(users_of_first_conversation.map { |user| user['id'] })
          .to include(compatible_target.user[:id], user[:id])
      end
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

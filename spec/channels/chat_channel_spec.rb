require 'rails_helper'

class TestConnection
  attr_reader :identifiers, :logger

  def initialize(identifiers_hash = {})
    @identifiers = identifiers_hash.keys
    @logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(StringIO.new))
    identifiers_hash.each do |identifier, value|
      define_singleton_method(identifier) do
        value
      end
    end
  end
end

RSpec.describe 'ChatChannel' do
  let(:first_user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:conversation) { create(:conversation, users: [first_user, second_user]) }
  subject(:channel) { ChatChannel.new(connection, {}) }
  let(:second_channel) { ChatChannel.new(second_connection, {}) }
  let(:action_cable) { ActionCable.server }
  let(:connection) do
    TestConnection.new(current_user: first_user,
                       params: { conversation_id: conversation.id },
                       server: action_cable)
  end

  let(:data) do
    {
      'action' => 'send_message',
      'conversation_id' => conversation.id,
      'content' => 'my message'
    }
  end

  it 'broadcasts a message to the match conversation' do
    expect(action_cable).to receive(:broadcast).once
    channel.perform_action(data)
    last_message = Message.last
    expect(last_message.text).to eq('my message')
    expect(last_message.user[:id]).to eq(first_user[:id])
  end
end

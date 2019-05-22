class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    ChatChannel.broadcast_to message.conversation, message_params(message.text, message.user)
  end

  def message_params(content, user)
    {
      content: content,
      action: 'new_message',
      user_id: user.id,
      date: Time.zone.now
    }
  end
end

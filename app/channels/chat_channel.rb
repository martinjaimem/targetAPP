class ChatChannel < ApplicationCable::Channel
  def subscribed
    return unless current_user.belongs_to_conversation?(conversation.id)

    conversation.connect_user(current_user)
    stream_for conversation
  end

  def unsubscribed
    return unless current_user.belongs_to_conversation?(conversation.id)

    conversation.disconnect_user(current_user)
  end

  def send_message(data)
    content = data['content']
    conversation.create_message(current_user, content)
  end

  private

  def conversation
    Conversation.find(params[:conversation_id])
  end
end

class ReadMessagesJob < ApplicationJob
  queue_as :default

  def perform(conversation, user)
    Message.update_read_attribute_of_user_and_conversation(conversation, user)
  end
end

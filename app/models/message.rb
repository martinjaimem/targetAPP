# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  text            :string           not null
#  user_id         :bigint
#  conversation_id :bigint
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :text, presence: true

  scope :not_read, -> { where(read: false) }
  scope :of_conversation, ->(conversation_id) { where(conversation_id: conversation_id) }
  scope :not_of_user, ->(user_id) { where.not(user_id: user_id) }
  scope :of_user, ->(user_id) { where(user_id: user_id) }
  scope :user_in_conversation, lambda { |user_id|
                                 joins(user_conversation: :message)
                                   .where('user_conversations.user_id': user_id)
                               }

  def broadcast_message(other_user_conversation)
    BroadcastMessageJob.perform_later(self)
    NotificationsJob.perform_later(
      [other_user_conversation.user.push_token],
      I18n.t('api.conversation.notification.new_message', from_username: user.username),
      user.username
    )
  end

  def self.update_read_attribute_of_user_and_conversation(conversation, user)
    of_conversation(conversation.id)
      .not_of_user(user.id)
      .not_read
      .update(read: true)
  end
end

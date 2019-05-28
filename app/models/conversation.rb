# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations

  validate :users_validations

  scope :with_unread_messages, -> { joins(:messages).where(messages: { read: false }).group(:id) }

  scope :users_in_conversation, lambda { |users_id|
                                  joins('INNER JOIN user_conversations uc_two ON
                                  conversations.id = uc_two.conversation_id')
                                    .where('uc_two.user_id': users_id)
                                }

  def connect_user(user)
    user_conv = user_conversations.of_user(user.id).first
    user_conv.update!(connected: true)
  end

  def create_message(user, text)
    other_user_conversation = user_conversations.not_of_user(user.id).first
    created_message = messages.create!(
      user_id: user.id,
      text: text,
      read: other_user_conversation.connected
    )
    created_message.broadcast_message(other_user_conversation)
  end

  def disconnect_user(user)
    user_conv = user_conversations.of_user(user.id).first
    user_conv.update!(connected: false)
  end

  def self.get_or_create_by_users(first_user, second_user)
    old_conversation = first_user.conversations.users_in_conversation([second_user]).first
    old_conversation || Conversation.create!(users: [first_user, second_user])
  end

  def self.get_converastions_of_user_with(original_user, with_users)
    original_user.conversations.users_in_conversation(with_users)
  end

  private

  def check_different_users
    return unless users.length == 2 && users[0].id == users[1].id

    errors.add(:users, I18n.t('api.conversation.user_validation.errors.different'))
  end

  def users_validations
    if users.length > 2
      errors.add(:users, I18n.t(
                           'api.conversation.user_validation.errors.length', number: users.length
                         ))
    else
      check_different_users
    end
  end
end

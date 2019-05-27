# == Schema Information
#
# Table name: user_conversations
#
#  id              :bigint           not null, primary key
#  user_id         :bigint
#  conversation_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  connected       :boolean          default(FALSE), not null
#  count           :integer          default(0), not null
#

class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :unread_messages_count, numericality: { greater_than_or_equal_to: 0 }

  scope :not_of_user, ->(user_id) { where.not(user_id: user_id) }
  scope :of_user, ->(user_id) { where(user_id: user_id) }

  def increment_counter_by_one
    increment!(:unread_messages_count)
  end

  def reset_counter
    update!(unread_messages_count: 0)
  end
end

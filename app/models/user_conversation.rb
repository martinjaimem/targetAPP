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
#

class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  scope :not_of_user, ->(user_id) { where.not(user_id: user_id) }
  scope :of_user, ->(user_id) { where(user_id: user_id) }
end

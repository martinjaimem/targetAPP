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

  scope :with_unread_messages, -> { joins(:messages).where(messages: { read: false } ).group(:id) }

  private

  def users_validations
    if users.length > 2
      errors.add(:users, I18n.t("must be less than 2, but there were #{users.length}"))
    elsif users.length == 2 && users[0].id == users[1].id
      errors.add(:users, I18n.t('must be different'))
    end
  end
end

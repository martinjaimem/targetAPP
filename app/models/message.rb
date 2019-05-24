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
end

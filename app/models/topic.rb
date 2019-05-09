# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :targets, dependent: :destroy

  validates :label, presence: true, uniqueness: true
end

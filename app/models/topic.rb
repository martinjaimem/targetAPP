# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ApplicationRecord
  validates :label, presence: true, uniqueness: true
end

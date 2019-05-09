# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  username   :string
#  gender     :decimal(, )
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :targets, dependent: :destroy

  enum gender: { male: 0, female: 1, other: 2 }

  validates :gender, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end

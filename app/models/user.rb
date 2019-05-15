# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  image                  :string
#  email                  :string
#  first_name             :string
#  last_name              :string
#  username               :string
#  gender                 :integer
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum gender: { male: 0, female: 1, other: 2 }

  validates :gender, presence: true

  def self.from_provider(provider, user_params)
    user_params.deep_symbolize_keys!
    where(provider: provider, uid: user_params[:id]).first_or_create! do |user|
      user.password = Devise.friendly_token[0, 20]
      user.email = user_params[:email]
      user.gender = 'other'
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end

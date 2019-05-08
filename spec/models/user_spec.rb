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

require 'rails_helper'

describe User, type: :model do
  context 'is a valid instance' do
    subject { FactoryBot.build(:user) }
    it 'saves correctly' do
      user = FactoryBot.build(:user)
      user.save!
      is_expected.to be_valid
    end
  end
  context 'isnt a valid instance' do
    context 'doesnt have gender' do
      user = User.new("username": 'dos',
                      "email": 'dos@dos.com',
                      "password": 'dosdos')
      subject { user }
      it { is_expected.to validate_presence_of(:gender) }
    end
  end
end

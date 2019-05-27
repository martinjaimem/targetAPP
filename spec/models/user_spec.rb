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
#  push_token             :string
#

require 'rails_helper'

describe User, type: :model do
  context 'when is a valid instance' do
    subject { build(:user) }
    it 'saves correctly' do
      subject.save!
      is_expected.to be_valid
    end
  end
  context 'when isnt a valid instance' do
    context 'when doesnt have gender' do
      user = User.new("username": 'dos',
                      "email": 'dos@dos.com',
                      "password": 'dosdos')
      subject { user }
      it { is_expected.to validate_presence_of(:gender) }
    end
  end
end

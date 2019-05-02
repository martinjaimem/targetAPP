require 'rails_helper'

RSpec.describe User, type: :model do
  it "saves an attribute" do
    user = User.new(
        first_name: "userfirstname1",
        email: 'usermail1@mail.com',
        last_name: "userlastname1",
        username: "username1",
        gender: "male"
    )
    user.save!
    expect(user).to be_valid
  end
end

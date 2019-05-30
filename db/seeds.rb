if Rails.env.development?
  AdminUser.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
end
%w[Burger Drinks Monkeys].each do |label|
  Topic.find_or_create_by(label: label)
end

michael_jordan = User.create!(
  email: 'michaelj23@gmail.com',
  password: 'michaelj23',
  password_confirmation: 'michaelj23',
  gender: 'male',
  username: 'michael_jordan'
)

lebron_james = User.create!(
  email: 'james_lebron@gmail.com',
  password: 'james_lebron',
  password_confirmation: 'james_lebron',
  gender: 'male',
  username: 'le_bron_james'
)

# remove this line to create conv manually via targets
Conversation.create!(users: User.all)
Target.find_or_create_by!(user: michael_jordan, title: 'a', lat: 23, lng: 45, radius: 67, topic: Topic.find_or_create_by(label: 'Monkeys'))
Target.find_or_create_by!(user: michael_jordan, title: 'b', lat: 55, lng: 55, radius: 67, topic: Topic.find_or_create_by(label: 'Drinks'))
Target.find_or_create_by!(user: michael_jordan, title: 'c', lat: 11, lng: 11, radius: 67, topic: Topic.find_or_create_by(label: 'Burger'))

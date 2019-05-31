if Rails.env.development?
  AdminUser.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
end
['Chicago Bulls', 'L.A. Lakers', 'Golden State Warriors'].each do |label|
  Topic.find_or_create_by(label: label)
end

michael_jordan = User.create!(
  email: 'michaelj23@gmail.com',
  first_name: 'Michael',
  last_name: 'Jordan',
  password: 'michaelj23',
  password_confirmation: 'michaelj23',
  gender: 'male',
  username: 'michael_jordan'
)

lebron_james = User.create!(
  email: 'james_lebron@gmail.com',
  first_name: 'LeBron',
  last_name: 'James',
  password: 'james_lebron',
  password_confirmation: 'james_lebron',
  gender: 'male',
  username: 'le_bron_james'
)

stephen_curry = User.create!(
  email: 'stephen_curry@gmail.com',
  password: 'stephen_curry',
  first_name: 'Stephen',
  last_name: 'Curry',
  password_confirmation: 'stephen_curry',
  gender: 'male',
  username: 'stephen_curry'
)

# kobe_briant = User.create!(
#   email: 'kobe_briant@gmail.com',
#   password: 'kobe_briant',
#   first_name: 'Kobe',
#   last_name: 'Briant',
#   password_confirmation: 'kobe_briant',
#   gender: 'male',
#   username: 'kobe_briant'
# )

# remove this line to create conv manually via targets
Conversation.create!(users: [michael_jordan, lebron_james])
Target.find_or_create_by!(user: michael_jordan, title: 'Bulls fan', lat: 23, lng: 45, radius: 67, topic: Topic.find_or_create_by(label: 'Chicago Bulls'))
Target.find_or_create_by!(user: lebron_james, title: 'Lakers fan', lat: 55, lng: 55, radius: 67, topic: Topic.find_or_create_by(label: 'L.A. Lakers'))
Target.find_or_create_by!(user: stephen_curry, title: 'GSW fan', lat: 11, lng: 11, radius: 67, topic: Topic.find_or_create_by(label: 'Golden State Warriors'))

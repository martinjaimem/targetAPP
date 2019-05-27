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

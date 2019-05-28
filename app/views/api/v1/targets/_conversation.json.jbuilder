json.id conversation.id
json.users do
  json.array!(conversation.users, partial: 'user', as: :user)
end

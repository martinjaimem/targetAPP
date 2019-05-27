json.id conversation.id
json.users conversation.users, partial: 'api/v1/users/user', as: :user
json.unread_messages_count conversation.unread_messages_count(current_user)

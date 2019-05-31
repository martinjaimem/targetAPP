ActiveAdmin.register Conversation do
  permit_params :email, :password, :password_confirmation, :username, :gender

  index do
    selectable_column
    id_column
    column('first user id') { |resource| resource.user_conversations.first.user.id }
    column('first user username') { |resource| resource.user_conversations.first.user.username }
    column('second user id') { |resource| resource.user_conversations[1].user.id }
    column('second user username') { |resource| resource.user_conversations[1].user.username }
    actions
  end

  filter :user_id
  filter :topic_id
end

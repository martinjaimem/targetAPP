ActiveAdmin.register Target do
  permit_params :email, :password, :password_confirmation, :username, :gender

  index do
    selectable_column
    id_column
    column :topic_id
    column('topic label') { |resource| resource.topic.label }
    column :user_id
    column('username') { |resource| resource.user.username }
    column :lat
    column :lng
    column :radius
    actions
  end

  filter :user_id
  filter :topic_id
end

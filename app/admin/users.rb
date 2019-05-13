ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :username, :gender

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :gender
    actions
  end

  filter :email
  filter :username
  filter :gender

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :gender, as: :select, collection: User.genders.keys
    end
    f.actions
  end
end

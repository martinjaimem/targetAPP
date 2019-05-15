class AddUserRefToTargets < ActiveRecord::Migration[5.2]
  def change
    remove_column :targets, :user_id
    add_reference :targets, :user, foreign_key: true
  end
end

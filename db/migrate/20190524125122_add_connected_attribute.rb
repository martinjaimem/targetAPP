class AddConnectedAttribute < ActiveRecord::Migration[5.2]
  def change
    add_column :user_conversations, :connected, :boolean, null: false, default: false
  end
end

class AddCountAttribute < ActiveRecord::Migration[5.2]
  def change
    add_column :user_conversations, :unread_messages_count, :integer, null: false, default: 0
  end
end

class AddTopicAndUserToTarget < ActiveRecord::Migration[5.2]
  def change
    add_index :targets, :topic_id
    add_index :targets, :user_id
  end
end

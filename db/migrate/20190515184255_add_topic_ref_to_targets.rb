class AddTopicRefToTargets < ActiveRecord::Migration[5.2]
  def change
    remove_column :targets, :topic_id
    add_reference :targets, :topic, foreign_key: true
  end
end

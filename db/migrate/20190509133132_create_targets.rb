class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.integer :user_id
      t.integer :topic_id
      t.decimal :radius
      t.float :lat
      t.float :lng
      t.string :title

      t.timestamps
    end
  end
end

class CreateNotificationFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_follows do |t|
      t.integer :follow_id, null: false
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.boolean :checked, null: false, default: false
      t.timestamps
    end
  end
end

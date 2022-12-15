class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :favorite_id, null: false
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.boolean :checked, null: false, default: false
      t.timestamps
    end
  end
end

class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :customer_id, null: false
      t.integer :favorite_id
      t.integer :comment_id
      t.integer :post_id
      t.integer :follow_id
      t.string :action, null: false
      t.boolean :checked, null: false, default: false
      t.timestamps
    end
  end
end

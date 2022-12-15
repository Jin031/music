class CreatePostGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :post_genres do |t|
      t.integer :customer_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
  end
end
     
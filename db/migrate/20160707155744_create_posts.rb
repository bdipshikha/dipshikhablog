class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.text :image
      t.integer :created_by
      t.integer :category_id

      t.timestamps null: false
    end
  end
end

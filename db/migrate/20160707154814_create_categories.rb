class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :title
      t.text :content
      t.text :image
      t.integer :created_by

      t.timestamps null: false
    end
  end
end

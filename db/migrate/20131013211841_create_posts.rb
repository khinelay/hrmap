class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :brief
      t.text :content
      t.integer :user_id
      t.string :category

      t.timestamps
    end
  end
end

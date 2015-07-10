class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_type
      t.string :user
      t.text :text
      t.string :ts

      t.timestamps
    end
  end
end

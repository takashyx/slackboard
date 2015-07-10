class CreateStarredPosts < ActiveRecord::Migration
  def change
    create_table :starred_posts do |t|
      t.string :post_type
      t.string :ts
      t.string :user
      t.text :text

      t.timestamps
    end
  end
end

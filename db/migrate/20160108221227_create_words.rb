class CreateWords < ActiveRecord::Migration[4.2]
  def change
    create_table :words do |t|
      t.string :word
      t.integer :count
      t.boolean :ignore_flag
      t.integer :last_post_id

      t.timestamps
    end
  end
end

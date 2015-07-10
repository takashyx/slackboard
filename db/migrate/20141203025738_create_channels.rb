class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :ch_id
      t.string :name
      t.integer :created
      t.string :creator
      t.boolean :is_archived
      t.integer :num_members
      t.string :topic_value
      t.string :topic_creator
      t.integer :topic_last_set
      t.string :purpose_value
      t.string :purpose_creator
      t.integer :purpose_last_set

      t.timestamps
    end
  end
end

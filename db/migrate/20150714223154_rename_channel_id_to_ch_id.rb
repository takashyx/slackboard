class RenameChannelIdToChId < ActiveRecord::Migration
  def change
    rename_column :posts, :channel_id, :ch_id
  end
end

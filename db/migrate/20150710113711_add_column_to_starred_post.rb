class AddColumnToStarredPost < ActiveRecord::Migration
  def change
    add_column :starred_posts, :ts_date, :datetime
  end
end

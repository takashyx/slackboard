class AddColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :ts_date, :datetime
  end
end

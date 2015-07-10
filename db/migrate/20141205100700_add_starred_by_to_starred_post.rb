class AddStarredByToStarredPost < ActiveRecord::Migration
  def change
    add_column :starred_posts, :starred_by, :string
  end
end

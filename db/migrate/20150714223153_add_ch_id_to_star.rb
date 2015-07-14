class AddChIdToStar < ActiveRecord::Migration
  def change
    add_column :stars, :ch_id, :string
  end
end

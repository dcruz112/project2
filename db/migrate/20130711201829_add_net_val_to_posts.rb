class AddNetValToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :net_val, :integer
  end
end

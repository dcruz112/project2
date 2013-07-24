class RemoveNetValFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :net_val, :integer
  end
end

class RemoveAnonFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :anon, :boolean
  end
end

class AddNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :name, :boolean
  end
end

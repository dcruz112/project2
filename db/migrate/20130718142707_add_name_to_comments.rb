class AddNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :name, :boolean
  end
end

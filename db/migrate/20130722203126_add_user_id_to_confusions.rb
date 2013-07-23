class AddUserIdToConfusions < ActiveRecord::Migration
  def change
    add_column :confusions, :user_id, :integer
  end
end

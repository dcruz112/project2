class RemoveUsersIdFromLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :users_id, :integer
  end
end

class RemoveUserIdFromLectures < ActiveRecord::Migration
  def change
    remove_column :lectures, :user_id, :integer
  end
end

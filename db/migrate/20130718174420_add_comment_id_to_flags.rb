class AddCommentIdToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :comment_id, :integer
  end
end

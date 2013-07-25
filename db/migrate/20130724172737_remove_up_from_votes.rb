class RemoveUpFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :up, :boolean
  end
end

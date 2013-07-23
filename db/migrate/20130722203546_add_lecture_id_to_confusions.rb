class AddLectureIdToConfusions < ActiveRecord::Migration
  def change
    add_column :confusions, :lecture_id, :integer
  end
end

class AddLectureIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :lecture_id, :integer
  end
end

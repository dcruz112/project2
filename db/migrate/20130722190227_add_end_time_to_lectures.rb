class AddEndTimeToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :end_time, :datetime
  end
end

class AddCurrentToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :current, :boolean
  end
end

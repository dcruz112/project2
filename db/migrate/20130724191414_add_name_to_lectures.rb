class AddNameToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :name, :string
  end
end

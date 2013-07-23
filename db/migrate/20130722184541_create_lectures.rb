class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.references :users, index: true

      t.timestamps
    end
  end
end

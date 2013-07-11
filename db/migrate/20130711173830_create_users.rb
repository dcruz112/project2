class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :student
      t.string :netid
      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :class_year

      t.timestamps
    end
  end
end

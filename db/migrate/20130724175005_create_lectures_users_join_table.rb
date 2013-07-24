class CreateLecturesUsersJoinTable < ActiveRecord::Migration
  def change
  	create_table :lectures_users do |t|
      t.belongs_to :lecture
      t.belongs_to :user
    end
  end
end

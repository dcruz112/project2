class CreateConfusions < ActiveRecord::Migration
  def change
    create_table :confusions do |t|

      t.timestamps
    end
  end
end

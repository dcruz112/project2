class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.references :user, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end

class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :status
      t.integer :num , :unique => true

      t.timestamps
    end
  end
end

class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.boolean :status
      t.string :p_name
      t.string :descr
      t.string :name

      t.timestamps
    end
  end
end

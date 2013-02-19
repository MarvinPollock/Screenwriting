class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :descr
      t.string :p_name
      t.string :actor

      t.timestamps
    end
  end
end

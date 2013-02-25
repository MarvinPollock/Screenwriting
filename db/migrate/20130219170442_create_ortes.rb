class CreateOrtes < ActiveRecord::Migration
  def change
    create_table :ortes do |t|
      t.string :name
      t.string :env
      t.string :descr
      t.string :p_name
      t.datetime :day
      t.string :comment

      t.timestamps
    end
  end
end

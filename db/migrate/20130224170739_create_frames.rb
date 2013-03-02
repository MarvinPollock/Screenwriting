class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.string :name
      t.integer :pad_id
      t.string :image
      t.string :descr

      t.timestamps
    end
  end
end

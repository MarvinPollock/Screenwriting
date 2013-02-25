class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.string :name
      t.binary :image
      t.string :descr

      t.timestamps
    end
  end
end

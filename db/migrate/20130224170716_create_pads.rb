class CreatePads < ActiveRecord::Migration
  def change
    create_table :pads do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end

class CreatePads < ActiveRecord::Migration
  def change
    create_table :pads do |t|
      t.string :title
      t.string :story
      t.text :content

      t.timestamps
    end
  end
end

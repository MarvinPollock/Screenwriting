class AddPadToFrame < ActiveRecord::Migration
  def change
    add_column :frames, :pad, :string
  end
end

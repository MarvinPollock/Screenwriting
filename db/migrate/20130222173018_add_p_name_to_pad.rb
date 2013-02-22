class AddPNameToPad < ActiveRecord::Migration
  def change
    add_column :pads, :p_name, :string
  end
end

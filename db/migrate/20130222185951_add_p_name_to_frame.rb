class AddPNameToFrame < ActiveRecord::Migration
  def change
    add_column :frames, :p_name, :string
  end
end

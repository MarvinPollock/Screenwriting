class AddPadIdToFrames < ActiveRecord::Migration
  def self.up
    add_column :frames, :pad_id, :integer
    add_index :frames, :pad_id
  end

  def self.down
    remove_index :frames, :pad_id
    remove_column :frames, :pad_id
  end
end

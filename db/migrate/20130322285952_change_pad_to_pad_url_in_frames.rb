class ChangePadToPadUrlInFrames < ActiveRecord::Migration
  def up
    rename_column :frames, :pad, :pad_url
  end

  def down
    rename_column :frames, :pad_url, :pad
  end
end

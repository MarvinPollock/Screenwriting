class ChangePadToPadname < ActiveRecord::Migration
  def up
    def change
      add_column :frames, :padname, :string
    end
  end

  def down
  end
end

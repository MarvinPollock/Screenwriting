class ChangeChangedToChangedDate < ActiveRecord::Migration
  def up
    rename_column :projects, :changed, :changed_date
  end

  def down
  end
end

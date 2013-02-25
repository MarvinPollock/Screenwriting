class AddGroupIdToProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :group_id
    add_column :projects, :group_id, :integer
    add_index :projects, :group_id
  end

  def self.down
    remove_index :projects, :group_id
    remove_column :projects, :group_id
  end
end

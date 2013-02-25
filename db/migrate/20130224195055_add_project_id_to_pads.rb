class AddProjectIdToPads < ActiveRecord::Migration
  def self.up
    add_column :pads, :project_id, :integer
    add_index :pads, :project_id
  end

  def self.down
    remove_index :pads, :project_id
    remove_column :pads, :project_id
  end
end

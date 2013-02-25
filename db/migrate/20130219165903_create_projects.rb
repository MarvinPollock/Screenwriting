class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :group_id
      t.datetime :created
      t.datetime :changed

      t.timestamps
    end
  end
end

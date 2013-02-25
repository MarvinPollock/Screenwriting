class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :lastname
      t.string :name
      t.integer :group_id
      t.string :role
      t.string :identifier_url

      t.timestamps
    end
  end
end

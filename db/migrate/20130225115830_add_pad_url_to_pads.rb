class AddPadUrlToPads < ActiveRecord::Migration
  def change
    add_column :pads, :pad_url, :string
  end
end

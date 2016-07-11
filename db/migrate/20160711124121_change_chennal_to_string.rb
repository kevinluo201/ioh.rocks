class ChangeChennalToString < ActiveRecord::Migration
  def change
  	remove_column :lives, :chennal
  	add_column :lives, :chennal, :string
  end
end

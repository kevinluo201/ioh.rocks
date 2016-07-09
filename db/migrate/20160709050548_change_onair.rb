class ChangeOnair < ActiveRecord::Migration
  def change
  	remove_column :lives, :onair
  	add_column :lives, :onair, :boolean, :default => false
  end
end

class AddLive < ActiveRecord::Migration
  def change
  	add_column :lives, :school, :string
  	add_column :lives, :department, :string
  end
end

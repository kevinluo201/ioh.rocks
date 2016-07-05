class AddLivesColumn < ActiveRecord::Migration
  def change
  	add_column :lives, :gmail, :string
  	add_column :lives, :fb_url, :string
  	add_column :lives, :phone, :string
  	add_column :lives, :stream_201602, :boolean
  	add_column :lives, :location, :string
  	add_column :lives, :ioh_url, :string
  end
end

class AddBannerLinkToLive < ActiveRecord::Migration
  def change
  	add_column :lives, :banner_link, :string
  	add_column :lives, :move_to_part_3, :boolean
  end
end

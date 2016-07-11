class AddALotToLive < ActiveRecord::Migration
  def change
  	add_column :lives, :banner_status, :string
  	add_column :lives, :embed_link_status, :string
  	add_column :lives, :no_show, :boolean, :default => false
  	add_column :lives, :in_studio, :boolean, :default => false
  	add_column :lives, :video_download, :boolean, :default => false
  	add_column :lives, :speaker_screenshot, :boolean, :default => false
  	add_column :lives, :youtube_naming, :string
  	add_column :lives, :save_to_hard_drive, :boolean, :default => false
  	add_column :lives, :paste_survey_link, :boolean, :default => false
  	remove_column :lives, :onair
  end
end

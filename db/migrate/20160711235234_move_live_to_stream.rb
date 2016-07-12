class MoveLiveToStream < ActiveRecord::Migration
  def change
  	remove_column :lives, :chennal
  	remove_column :lives, :live_host

  	add_column :streams, :youtube_url, :string
  	add_column :streams, :phone_contact, :boolean, :default => false
  	add_column :streams, :qa_link, :string
  	add_column :streams, :doc_naming, :string
  	add_column :streams, :stream_naming, :string
  	add_column :streams, :test_record, :string
  	add_column :streams, :move_to_part_3, :boolean, :default => false
  	add_column :streams, :banner_status, :string
  	add_column :streams, :embed_link_status, :string
  	add_column :streams, :no_show, :boolean, :default => false
  	add_column :streams, :in_studio, :boolean, :default => false
  	add_column :streams, :video_download, :boolean, :default => false
  	add_column :streams, :speaker_screenshot, :boolean, :default => false
  	add_column :streams, :youtube_naming, :string
  	add_column :streams, :save_to_hard_drive, :boolean, :default => false
  	add_column :streams, :paste_survey_link, :boolean, :default => false
  	add_column :streams, :audio_agree, :boolean, :default => false

  	remove_column :lives, :youtube_url
  	remove_column :lives, :phone_contact
  	remove_column :lives, :qa_link
  	remove_column :lives, :doc_naming
  	remove_column :lives, :stream_naming
  	remove_column :lives, :test_record
  	remove_column :lives, :move_to_part_3
  	remove_column :lives, :banner_status
  	remove_column :lives, :embed_link_status
  	remove_column :lives, :no_show
  	remove_column :lives, :in_studio
  	remove_column :lives, :video_download
  	remove_column :lives, :speaker_screenshot
  	remove_column :lives, :youtube_naming
  	remove_column :lives, :save_to_hard_drive
  	remove_column :lives, :paste_survey_link
  	remove_column :lives, :audio_agree
  end
end

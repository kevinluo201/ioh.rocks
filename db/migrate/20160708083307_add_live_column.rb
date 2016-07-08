class AddLiveColumn < ActiveRecord::Migration
  def change
  	add_column :lives, :chennal, :integer
  	add_column :lives, :youtube_url, :string
  	add_column :lives, :live_host, :string
  	add_column :lives, :audio_agree, :boolean
  	add_column :lives, :qa_link, :string
  	add_column :lives, :stream_naming, :string
  	add_column :lives, :doc_namimg, :string
  end
end

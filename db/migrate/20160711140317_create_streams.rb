class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
    	t.string :name
    	t.string :chennal
    	t.string :live_host
    	t.references :live, references: :lives, index: true
    	t.foreign_key :lives, column: :live_id
    	t.references :live_time, index: true, foreign_key: true
    end
  end
end

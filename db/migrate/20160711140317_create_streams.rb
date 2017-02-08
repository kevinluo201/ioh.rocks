class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
    	t.string :name
    	t.string :live_host
    end
  end
end

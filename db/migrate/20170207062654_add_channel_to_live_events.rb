class AddChannelToLiveEvents < ActiveRecord::Migration
  def change
    add_column :live_events, :channels, :integer
  end
end

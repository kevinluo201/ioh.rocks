class AddColumnLiveEventIdToLiveTime < ActiveRecord::Migration
  def change
    add_column :live_times, :live_event_id, :integer
  end
end

class AddChannelToLiveTimesAppointments < ActiveRecord::Migration
  def change
    add_column :live_time_appointments, :channel, :string
  end
end

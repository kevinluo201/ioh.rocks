class AddLiveTimeAppointmentIdToStream < ActiveRecord::Migration
  def change
    add_reference :streams, :live_time_appointment, index: true
  end
end

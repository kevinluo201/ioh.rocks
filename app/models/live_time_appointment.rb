class LiveTimeAppointment < ActiveRecord::Base
  belongs_to :live
  belongs_to :live_time

  def self.appointments_of_active_event
    joins(:live_time).where('live_times.live_event_id' => LiveEvent.active_event.id)
  end
end

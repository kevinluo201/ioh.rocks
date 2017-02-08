class LiveTimeAppointment < ActiveRecord::Base
  belongs_to :live
  belongs_to :live_time
  has_one :stream, dependent: :destroy

  after_create :make_a_stream

  def self.appointments_of_active_event
    includes(:live_time, :live).joins(:live_time).where('live_times.live_event_id' => LiveEvent.active_event.id)
  end

  private

  def make_a_stream
    unless stream
      Stream.create(live_time_appointment: self)
    end
  end
end

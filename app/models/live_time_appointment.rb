class LiveTimeAppointment < ActiveRecord::Base
  belongs_to :live
  belongs_to :live_time
  has_one :stream, dependent: :destroy

  after_create :make_a_stream
  after_create :connect_live_and_event

  def self.appointments_of_active_event
    includes(:live_time, :live).joins(:live_time).where('live_times.live_event_id' => LiveEvent.active_event.id)
  end

  private

  def make_a_stream
    unless stream
      Stream.create(live_time_appointment: self)
    end
  end

  def connect_live_and_event
    unless live.live_events.include? live_time.live_event
      live.live_events << live_time.live_event
      live.save
    end
  end
end

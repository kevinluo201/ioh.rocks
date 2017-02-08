require 'test_helper'

class LiveTimeAppointmentTest < ActiveSupport::TestCase
  test "appointments_of_active_event only return the apps of the active event" do
    event1 = LiveEvent.make!(active: true)
    event2 = LiveEvent.make!(active: false)

    20.times { Live.make!(live_times: [event1.live_times.first]) }
    30.times { Live.make!(live_times: [event2.live_times.first]) }

    LiveTimeAppointment.appointments_of_active_event.each do |app|
      assert_equal event1.live_times.first, app.live_time
    end
  end
end

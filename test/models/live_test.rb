require 'test_helper'

class LiveTest < ActiveSupport::TestCase
  test "inactive lives" do
    event1 = LiveEvent.make!(active: true)
    event2 = LiveEvent.make!
    event3 = LiveEvent.make!

    [event1, event2, event3].each do |e|
      3.times { Live.make!(live_times: [e.live_times.first]) }
    end

    assert_equal 6, Live.inactive_lives.count

    Live.inactive_lives.each do |l|
      assert_equal 1, l.live_events.count
      assert_not_equal event1, l.live_events.first
    end
  end
end

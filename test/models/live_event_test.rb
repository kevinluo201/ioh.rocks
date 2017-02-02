require 'test_helper'

class LiveEventTest < ActiveSupport::TestCase
  test "event is inavtice after creation" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today)

    assert !event.active?
  end

  test "live_event should have according livetimes" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today)

    sum = 0
    event.live_times.each { |t| sum += 1 }

    assert 10, sum
  end
end

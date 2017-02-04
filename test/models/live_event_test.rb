require 'test_helper'

class LiveEventTest < ActiveSupport::TestCase
  test "event is inavtice after creation" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today)

    assert !event.active?
  end

  test "event end date is always 2days after start date" do
    event = LiveEvent.create(start_date: Date.today, signup_end: Date.today)

    assert_equal Date.today + 2.days, event.end_date
  end

  test "live_event should have according livetimes" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today)

    sum = 0
    event.live_times.each { |t| sum += 1 }

    assert 10, sum
  end

  test "find active event" do
    event1 = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today,
                             active: true)
    event2 = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today,
                             active: false)
    assert_equal event1, LiveEvent.active_event
  end
end

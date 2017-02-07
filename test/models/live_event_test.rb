require 'test_helper'

class LiveEventTest < ActiveSupport::TestCase
  test "event is inavtice after creation" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today)

    assert !event.active?
  end

  test "period return the range of start and end" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 20.days,
                             signup_end: Date.today)
    assert_equal Date.today..(Date.today + 20.days), event.period
  end

  test "pength return the days count of start and end" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 20.days,
                             signup_end: Date.today)
    assert_equal 21, event.length
  end

  test "live_event should have according livetimes" do
    event = LiveEvent.create(start_date: Date.today,
                             end_date: Date.today + 2.days,
                             signup_end: Date.today)

    sum = LiveTime::Times.inject(0) { |sum, t| sum += 1 }
    event.period.each do |d|
      assert_equal sum, event.live_times.select { |t| t.start.to_date == d }.count
    end
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

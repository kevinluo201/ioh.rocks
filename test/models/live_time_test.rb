require 'test_helper'

class LiveTimeTest < ActiveSupport::TestCase
  test "create livetimes from date" do
    times = LiveTime.create_live_times_from_date(Date.today)

    LiveTime::Times.each do |t|
      assert !times.select { |tt| tt.start.strftime("%m/%d/%Y %-H:%M") == "#{Date.today.strftime('%m/%d/%Y')} #{t}" }.empty?
    end
  end
end

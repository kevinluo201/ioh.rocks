module Admin::LivesHelper
  def live_time_period(live_time)
    live_time.start.strftime('%H:%M') + "~" + live_time.end.strftime('%H:%M')
  end
end

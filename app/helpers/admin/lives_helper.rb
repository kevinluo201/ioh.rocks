module Admin::LivesHelper
  def live_time_period(live_time)
    live_time.start.strftime('%H:%M') + "~" + live_time.end.strftime('%H:%M')
  end

  # row number for appointments in agenda
  def row_number_for_apps(live_times, live_event)
    live_times.map { |t| t.live_time_appointments.count / live_event.channels.to_f }.max.ceil
  end
end

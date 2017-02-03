module AdminHelper
  def bootstrap_class_for flash_type
    case flash_type
    when :success then 'alert-success'
    when :error then 'alert-danger'
    when :alert then 'alert-warning'
    when :notice then 'alert-info'
    else flash_type
    end
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type.to_sym)} fade in") do
          concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
          concat message
        end
      )
    end
    nil
  end
end

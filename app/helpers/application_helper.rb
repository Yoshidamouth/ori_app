module ApplicationHelper
  def status_class(status)
    case status
    when '未対応'
      'status-unresponded'
    when '対応中'
      'status-responding'
    when '対応済'
      'status-completed'
    else
      ''
    end
  end
end
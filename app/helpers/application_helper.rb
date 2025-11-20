module ApplicationHelper
  def severity_badge_class(severity)
    case severity
    when 'minor'
      'badge-success'
    when 'moderate'
      'badge-warning'
    when 'significant'
      'badge-warning'
    when 'critical'
      'badge-danger'
    else
      'badge-secondary'
    end
  end
end

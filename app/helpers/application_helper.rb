module ApplicationHelper

  def status_color(status)
    case status
      when 'Onbekend'
        return 'blue'
      when 'Aangemeld'
        return 'green'
      when 'Afgemeld'
        return 'red'
    end

  end

  def band
    return Band.find(@cms_site.band_id) if @cms_site.present?
    return current_member.band unless current_member.nil?
    return Band.first
  end

  def decline_style(rehearsal_or_gig, member)
    rehearsal_or_gig.is_declined_by?(member) ? 'btn btn-sm btn-danger' : 'btn btn-sm btn-outline-danger'
  end

  def accept_style(rehearsal_or_gig, member)
    rehearsal_or_gig.is_accepted_by?(member) ? 'btn btn-sm btn-success' : 'btn btn-sm btn-outline-success'
  end

  def attended_style(rehearsal_or_gig, member)
    rehearsal_or_gig.is_attended_by?(member) ? 'btn btn-sm btn-success' : 'btn btn-sm btn-outline-success'
  end

  def not_attended_style(rehearsal_or_gig, member)
    rehearsal_or_gig.is_not_attended_by?(member) ? 'btn btn-sm btn-danger' : 'btn btn-sm btn-outline-danger'
  end

end

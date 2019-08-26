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

end

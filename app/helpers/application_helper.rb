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
    current_member.band
  end

end

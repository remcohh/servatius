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

end

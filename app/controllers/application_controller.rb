class ApplicationController < ActionController::Base
  before_action :set_band

  def current_ability
    @current_ability ||= Ability.new(current_member)
  end

  def set_band
    @band = Band.first
  end

end

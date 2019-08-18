module Availability
  extend ActiveSupport::Concern
  def calc_availability(gig)
    @instruments_availability = {}
    @instruments_availability_member = {}
    gig.ensembles.each do |ensemble|
      @instruments_availability[ensemble.id] = gig.instruments_availabability(ensemble)
      @instruments_availability_member[ensemble.id] = @instruments_availability[ensemble.id].find{ |i| i['id'] == current_member.ensemble_instruments.first.instrument_id }
    end
  end
end
class SongsController < ApplicationController
  before_action :authenticate_member!


  def index
    @songs = Song.for_member(current_member)
  end

  def show
    @song = Song.find(params[:id])
    current_member_ensemble_instruments = current_member.ensemble_instruments.where(ensemble_id: @song.ensemble_id)
    @parts = Part.where(song_id: @song.id).where(ensemble_instrument_id: current_member_ensemble_instruments.pluck(:id))
  end

end
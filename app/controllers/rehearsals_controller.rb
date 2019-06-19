class RehearsalsController < ApplicationController
  before_action :authenticate_member!


  def index
    @rehearsals = Rehearsal.upcoming_for_band(current_member.band_id)
  end

  def show
    @rehearsal = Rehearsal.find(params[:id])
  end

  def decline
    @rehearsal = Rehearsal.find(params[:id])
    @rehearsal.member_presences.create(member_id: current_member.id, will_be_present: false)
    redirect_to action: :index
  end

  def remove_decline
    @rehearsal = Rehearsal.find(params[:id])
    @rehearsal.member_presences.where(member_id: current_member.id).destroy_all
    redirect_to action: :index
  end

end
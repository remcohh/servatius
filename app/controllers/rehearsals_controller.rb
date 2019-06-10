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
    @rehearsal.rehearsal_declines.create(member_id: current_member.id)
    redirect_to action: :index
  end

  def remove_decline
    @rehearsal = Rehearsal.find(params[:id])
    @rehearsal.rehearsal_declines.where(member_id: current_member.id).destroy_all
    redirect_to action: :index
  end

end
class RehearsalsController < ApplicationController
  before_action :authenticate_member!


  def index
    @ensembles = current_member.ensembles
    @rehearsals = Rehearsal.upcoming_for_ensemble(current_member.ensembles.first)
  end

  def show
    @rehearsal = Rehearsal.find(params[:id])
  end

  def attendance
    @rehearsal = Rehearsal.find(params[:id])
    @declines = @rehearsal.member_presences.where(will_be_present: false)
    @absents = @rehearsal.member_presences.where(present: false)
    @unknown = @rehearsal.members.joins("LEFT JOIN member_presences on member_presences.member_id = members.id AND member_presences.presentable_type='Rehearsal'")
                                  .where('member_presences.id is NULL')
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

  def set_attendance_status
    @rehearsal = Rehearsal.find(params[:id])
    att = @rehearsal.member_presences.where(member_id: current_member.id).first_or_create
    att.update_attribute :present, params[:attendance]
    redirect_to rehearsal_attendance_path(@rehearsal)
  end
end
class RehearsalsController < ApplicationController
  before_action :authenticate_member!


  def index
    @ensembles = current_member.ensembles
    @rehearsals = Rehearsal.upcoming_for_ensemble(current_member.ensembles.first)
  end

  def show
    @rehearsal = Rehearsal.find(params[:id])
    @accepted_members_count = @rehearsal.accepted_members.count
    @declined_members_count = @rehearsal.declined_members.count
    @state = @rehearsal.max_present && @rehearsal.max_present - @accepted_members_count <= 0 ? :full : :available
  end

  def attendance
    @rehearsal = Rehearsal.find(params[:id])
    @declines = @rehearsal.member_presences.where(will_be_present: false)
    @absents = @rehearsal.member_presences.where(present: false)
    @attending = @rehearsal.member_presences.where(present: true)
    @members = @rehearsal.members.order("ensemble_instruments.id")
  end

  def decline
    @rehearsal = Rehearsal.find(params[:id])
    if @rehearsal.is_declined_by?(current_member)
      @rehearsal.member_presences.where(member_id: current_member.id).delete_all
    else
      member_presence = @rehearsal.member_presences.where(member_id: current_member.id).first
      if member_presence
        member_presence.update_attribute(:will_be_present, false)
      else
        @rehearsal.member_presences.create(member_id: current_member.id, will_be_present: false)
      end
    end
    redirect_to action: :show
  end

  def accept
    @rehearsal = Rehearsal.find(params[:id])
    if @rehearsal.is_accepted_by?(current_member)
      @rehearsal.member_presences.where(member_id: current_member.id).delete_all
    else
      member_presence = @rehearsal.member_presences.where(member_id: current_member.id).first
      if member_presence
        member_presence.update_attribute(:will_be_present, true)
      else
        @rehearsal.member_presences.create(member_id: current_member.id, will_be_present: true)
      end
    end
    redirect_to action: :show
  end

  def remove_decline
    @rehearsal = Rehearsal.find(params[:id])
    @rehearsal.member_presences.where(member_id: current_member.id).destroy_all
    redirect_to action: :index
  end

  def set_attendance_status
    @rehearsal = Rehearsal.find(params[:id])
    @members = @rehearsal.members.order("ensemble_instruments.id")
    att = @rehearsal.member_presences.where(member_id: params[:member_id]).first_or_create
    val = params[:attendance] == 'true'
    att.update_attribute :present, att.present == val ? nil : val
      #redirect_to rehearsal_attendance_path(@rehearsal)
  end

  def statistics
    @series = {}
    @ensembles = current_member.band.ensembles
    @ensembles.each do |ens|
      @series[ens.name] = [
          {
              name: 'Aanwezig',
              data: series_builder(ens.rehearsals, :present, true)
          },

          {
              name: 'Afwezig',
              data: series_builder(ens.rehearsals, :present, false)
          },
          {
              name: 'Afgemeld',
              data: series_builder(ens.rehearsals, :will_be_present, false)
          },
          {
              name: 'Onbekend',
              data: unknown_attendance_series(ens.rehearsals)
          }
      ]
    end

  end

  def series_builder(rehearsals, field, state)
    rehearsals.inject({}) do |h,r|
      h[r.date_time.strftime('%d-%m')] = r.member_presences.where(field => state).count
      h
    end
  end

  def unknown_attendance_series(rehearsals)
    rehearsals.inject({}) do |h,r|
      h[r.date_time.strftime('%d-%m')] = r.members.without_attendance.count
      h
    end
  end

end
class ChoresController < ApplicationController
  before_action :authenticate_member!


  def index
    @chores = Chore.all.for_band(current_member.band_id)
  end

  def show
    @chore = Chore.find(params[:id])
    @present_members = @chore.present_members
  end
  
  def set_attendance_status
    @chore = Chore.find(params[:id])
    att = @chore.member_presences.where(member_id: params[:member_id]).first_or_create
    if params[:attendance] == 'false'
      att.destroy
    else
      att.update_attribute :present, params[:attendance]
    end
    redirect_to chores_path
  end
end
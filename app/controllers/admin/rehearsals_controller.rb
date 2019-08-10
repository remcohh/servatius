class Admin::RehearsalsController < ApplicationController
  before_action :authenticate_member!

  def index
    @rehearsals = Rehearsal.all.order('date_time desc')
  end

  def show
    @rehearsal = Rehearsal.find(params[:id])
  end

  def edit
    @rehearsal = Rehearsal.find params[:id]
  end

  def update
    @rehearsal = Rehearsal.find params[:id]
    @rehearsal.update_attributes rehearsal_params
    redirect_to action: :index
  end

  def new
    @rehearsal = Rehearsal.new
    @rehearsal.description = 'Reguliere repetitie'
  end

  def create
    Rehearsal.create(rehearsal_params.merge(band_id: current_member.band_id))
    redirect_to action: :index
  end

  def destroy
    Rehearsal.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def rehearsal_params
    params.require(:rehearsal).permit(:date_time, :description, ensemble_ids: [])
  end
end

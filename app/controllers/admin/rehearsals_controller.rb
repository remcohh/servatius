class Admin::RehearsalsController < ApplicationController
  before_action :authenticate_member!

  def index
    @filterrific = initialize_filterrific(
        Rehearsal,
        params[:filterrific],
        select_options: {
        },
        persistence_id: "shared_key",
        default_filter_params: {list_filter: 'Toekomstig'},
        available_filters: [:upcoming, :description_filter, :list_filter],
        sanitize_params: true,
    ) || return

    @rehearsals = @filterrific.find
  end

  def show
    @rehearsal = Rehearsal.find(params[:id])
  end

  def edit
    @rehearsal = Rehearsal.find params[:id]
    3.times { @rehearsal.playable_songs.build }
  end

  def update
    @rehearsal = Rehearsal.find params[:id]
    @rehearsal.update rehearsal_params
    redirect_to action: :index
  end

  def new
    @rehearsal = Rehearsal.new
    @rehearsal.description = 'Reguliere repetitie'
    3.times { @rehearsal.playable_songs.build }

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
    params.require(:rehearsal).permit(:date_time, :description, ensemble_ids: [], playable_songs_attributes:[:_destroy, :id, :song_id, :remark])
  end
end

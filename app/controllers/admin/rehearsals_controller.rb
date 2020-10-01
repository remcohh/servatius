class Admin::RehearsalsController < ApplicationController
  before_action :authenticate_member!

  def index
    @filterrific = initialize_filterrific(
        Rehearsal,
        params[:filterrific],
        select_options: {
        },
        persistence_id: false,
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
    @rehearsal = Rehearsal.create(rehearsal_params.merge(band_id: current_member.band_id))
    group = Group.find(params[:group])
    group.members.each do |member|
      @rehearsal.member_presences.create(member_id: member.id, will_be_present: true)
    end
    redirect_to action: :index
  end

  def destroy
    Rehearsal.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def rehearsal_params
    params.require(:rehearsal).permit(:date_time, :max_present, :description, ensemble_ids: [], playable_songs_attributes:[:_destroy, :id, :song_id, :remark])
  end
end

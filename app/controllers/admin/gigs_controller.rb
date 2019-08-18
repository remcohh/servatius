class Admin::GigsController < ApplicationController
  include Availability

  before_action :authenticate_member!

  def index
    @filterrific = initialize_filterrific(
        Gig,
        params[:filterrific],
        select_options: {
        },
        persistence_id: "shared_key",
        default_filter_params: {},
        available_filters: [:sorted_by, :description_filter],
        sanitize_params: true,
    ) || return

    @gigs = @filterrific.find
  end

  def show
    @gig = Gig.find params[:id]
    calc_availability(@gig)
  end

  def edit
    @gig = Gig.find params[:id]
    3.times { @gig.playable_songs.build }
  end

  def update
    @gig = Gig.find params[:id]
    @gig.update gig_params
    redirect_to action: :index
  end

  def new
    @gig = Gig.new
    3.times { @gig.playable_songs.build }
  end

  def create
    Gig.create(gig_params.merge(band_id: current_member.band_id))
    redirect_to action: :index
  end

  def destroy
    Gig.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def gig_params
    params.require(:gig).permit(:title,
                                :where,
                                :date_time,
                                :where,
                                :gather_when,
                                :gather_where,
                                :dresscode,
                                :where_address1,
                                :where_address2,
                                :member_remarks,
                                :site_remarks,
                                ensemble_ids: [],
                                playable_songs_attributes:[:_destroy, :id, :song_id]
                                )
  end
end

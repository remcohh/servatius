class Admin::GigsController < ApplicationController
  before_action :authenticate_member!

  def index
    @filterrific = initialize_filterrific(
        Gig,
        params[:filterrific],
        select_options: {
        },
        persistence_id: "shared_key",
        default_filter_params: {},
        available_filters: [:sorted_by, :title_filter],
        sanitize_params: true,
    ) || return

    @gigs = @filterrific.find.page(params[:page])
  end

  def edit
    @gig = Gig.find params[:id]
  end

  def update
    @gig = Gig.find params[:id]
    @gig.update_attributes gig_params
    redirect_to action: :index
  end

  def new
    @gig = Gig.new
  end

  def create
    Gig.create(gig_params.merge(band_id: current_member.band_id, gig_admin: current_member))
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
                                ensemble_ids: []
                                )
  end
end

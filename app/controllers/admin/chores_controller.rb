class Admin::ChoresController < ApplicationController
  before_action :authenticate_member!

  def index

    @filterrific = initialize_filterrific(
        Chore,
        params[:filterrific],
        select_options: {
        },
        persistence_id: "shared_key",
        default_filter_params: {},
        available_filters: [:sorted_by, :title_filter],
        sanitize_params: true,
    ) || return

    @chores = @filterrific.find

  end

  def edit
    @chore = Chore.find params[:id]
  end

  def update
    @chore = Chore.find params[:id]
    @chore.update_attributes chore_params
    redirect_to action: :index
  end

  def new
    @chore = Chore.new
  end

  def create
    Chore.create(chore_params.merge(band_id: current_member.band_id))
    redirect_to action: :index
  end

  def destroy
    Chore.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def chore_params
    params.require(:chore).permit(:title, :date_time, :description, :coordinator_id, :min_number, :max_number )
  end

end

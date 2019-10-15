class Admin::GroupsController < ApplicationController
  before_action :authenticate_member!

  def index

    @filterrific = initialize_filterrific(
        Group,
        params[:filterrific],
        select_options: {
        },
        persistence_id: false,
        default_filter_params: {},
        available_filters: [:sorted_by, :name_filter],
        sanitize_params: true,
    ) || return

    @groups = @filterrific.find


  end

  def show
    @group = Group.find params[:id]
  end

  def edit
    @group = Group.find params[:id]
  end

  def update
    @group = Group.find params[:id]
    @group.update_attributes group_params
    redirect_to action: :index
  end

  def new
    @group = Group.new
  end

  def create
    Group.create(group_params.merge(band_id: current_member.band_id))
    redirect_to action: :index
  end


  def destroy
    Group.find(params[:id]).destroy
    redirect_to action: :index
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :member_ids => [])
  end



end

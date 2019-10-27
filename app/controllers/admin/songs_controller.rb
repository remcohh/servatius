class Admin::SongsController < ApplicationController
  before_action :authenticate_member!

  def index

    @filterrific = initialize_filterrific(
        Song,
        params[:filterrific],
        select_options: {
        },
        persistence_id: false,
        default_filter_params: {},
        available_filters: [:sorted_by, :title_filter, :ensemble_filter],
        sanitize_params: true,
    ) || return

    @songs = @filterrific.find


  end

  def edit
    @song = Song.find params[:id]
    @song.parts.build if params[:build_new] == 'true'
  end

  def update
    @song = Song.find params[:id]
    @song.update_attributes song_params
    if params[:next_action] == '+'
      redirect_to action: :edit, build_new: true
    else
      redirect_to action: :index
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.create(song_params.merge(band_id: current_member.band_id))
    if params[:next_action] == '+'
      redirect_to action: :edit, id: @song.id, build_new: true
    else
      redirect_to action: :index
    end
  end

  def destroy
    Song.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def song_params
    p = params.require(:song).permit(:title, :composer, :state, :ensemble_id, parts_attributes: [:id, :ensemble_instrument_id, :upload] )
    p[:parts_attributes] = p[:parts_attributes].to_h.except("id")
    p
  end

end

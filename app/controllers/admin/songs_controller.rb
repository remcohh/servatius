class Admin::SongsController < ApplicationController
  before_action :authenticate_member!

  def index

    @filterrific = initialize_filterrific(
        Song,
        params[:filterrific],
        select_options: {
        },
        persistence_id: "shared_key",
        default_filter_params: {},
        available_filters: [:sorted_by, :title_filter],
        sanitize_params: true,
    ) || return

    @songs = @filterrific.find.page(params[:page])


  end

  def edit
    @song = Song.find params[:id]
  end

  def update
    @song = Song.find params[:id]
    @song.update_attributes song_params
    redirect_to action: :index
  end

  def new
    @song = Song.new
  end

  def create
    Song.create(song_params)
    redirect_to action: :index
  end

  def destroy
    Song.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def song_params
    params.require(:song).permit(:title, :composer, :state)
  end

end

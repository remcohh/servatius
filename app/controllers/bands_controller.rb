class BandsController < ApplicationController

  def index
    @bands = Band.all
  end

  def edit
    @band = Band.find params[:id]
  end

  def update
    @band = Band.find params[:id]
    @band.update_attributes band_params
    redirect_to action: :index
  end

  def new
    @band = Band.new
  end

  def create
    Band.create(band_params)
    redirect_to action: :index
  end

  def destroy
    Band.find(params[:id]).destroy!
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

end

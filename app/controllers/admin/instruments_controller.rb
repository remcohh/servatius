class Admin::InstrumentsController < ApplicationController
  before_action :authenticate_member!

  def index

    @filterrific = initialize_filterrific(
        Instrument,
        params[:filterrific],
        select_options: {
        },
        persistence_id: "shared_key",
        default_filter_params: {},
        available_filters: [:sorted_by, :name_filter],
        sanitize_params: true,
    ) || return

    @instruments = @filterrific.find


  end

  def edit
    @instrument = Instrument.find params[:id]
  end

  def update
    @instrument = Instrument.find params[:id]
    @instrument.update_attributes instrument_params
    redirect_to action: :index
  end

  def new
    @instrument = Instrument.new
  end

  def create
    Instrument.create(instrument_params.merge(band_id: current_member.band_id))
    redirect_to action: :index
  end

  def destroy
    Instrument.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def instrument_params
    params.require(:instrument).permit(:title, :composer, :state)
  end

end

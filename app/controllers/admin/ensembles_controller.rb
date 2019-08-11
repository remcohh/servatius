class Admin::EnsemblesController < ApplicationController
  before_action :authenticate_member!

  def index

    @filterrific = initialize_filterrific(
        Ensemble,
        params[:filterrific],
        select_options: {
        },
        persistence_id: 'shared_key',
        default_filter_params: {},
        available_filters: [:sorted_by, :name_filter],
        sanitize_params: true,
    ) || return

    @ensembles = @filterrific.find.page(params[:page])


  end

  def show
    @ensemble = Ensemble.find params[:id]
    @ensemble_instrument = EnsembleInstrument.new
  end

  def edit
    @ensemble = Ensemble.find params[:id]
  end

  def update
    @ensemble = Ensemble.find params[:id]
    @ensemble.update_attributes ensemble_params
    redirect_to action: :index
  end

  def new
    @ensemble = Ensemble.new
  end

  def create
    Ensemble.create(ensemble_params.merge(band_id: current_member.band_id))
    redirect_to action: :index
  end

  def add_instrument
    @ensemble = Ensemble.find params[:ensemble_id]
    ei = @ensemble.ensemble_instruments.create ensemble_instrument_params
    if ei.valid?
      redirect_to admin_ensemble_path @ensemble
    else
      flash[:error] = ei.errors.collect {|_,v| v}.join(',')
      redirect_to admin_ensemble_path @ensemble
    end
  end

  def delete_instrument
    @ensemble = Ensemble.find params[:ensemble_id]
    EnsembleInstrument.delete params[:id]
    redirect_to admin_ensemble_path @ensemble
  end

  def destroy
    Ensemble.find(params[:id]).destroy
    redirect_to action: :index
  end

  private

  def ensemble_params
    params.require(:ensemble).permit(:name)
  end

  def ensemble_instrument_params
    params.require(:ensemble_instrument).permit(:instrument_id, :party)
  end

end

class GigsController < ApplicationController
  before_action :authenticate_member!

  before_action :set_gig, only: [:show, :edit, :update, :destroy, :signup, :dropout]

  # GET /gigs
  # GET /gigs.json
  def index
    @ensembles = current_member.ensembles
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
    @instruments_availability = {}
    @instruments_availability_member = {}
    @gig.ensembles.each do |ensemble|
      @instruments_availability[ensemble.id] = @gig.instruments_availabability(ensemble)
      @instruments_availability_member[ensemble.id] = @instruments_availability[ensemble.id].find{ |i| i['id'] == current_member.ensemble_instruments.first.instrument_id }
    end
    presence = @gig.presence_for_member(current_member)
    @status = if presence.nil?
                'Onbekend'
              elsif presence
                'Aangemeld'
              else
                'Afgemeld'
              end
  end

  # GET /gigs/new
  def new
    @gig_admins = Member.where(gig_admin: true)
    @gig = Gig.new
  end

  # GET /gigs/1/edit
  def edit
    @gig_admins = Member.where(gig_admin: true)
  end

  def accept
    set_presence true
    redirect_to action: :index
  end

  def decline
    set_presence false
    redirect_to action: :index
  end

  def create
    @gig = Gig.new(gig_params)
    @gig.gig_admin = Member.find(gig_params[:gig_admin_id])
    respond_to do |format|
      if @gig.save
        format.html { redirect_to @gig, notice: 'Gig was successfully created.' }
        format.json { render :show, status: :created, location: @gig }
      else
        format.html { render :new }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @gig.update(gig_params)
        format.html { redirect_to @gig, notice: 'Gig was successfully updated.' }
        format.json { render :show, status: :ok, location: @gig }
      else
        format.html { render :edit }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @gig.destroy
    respond_to do |format|
      format.html { redirect_to gigs_url, notice: 'Gig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def signup
    @gig.players << @current_member unless @gig.players.include? @current_member
    respond_to do |format|
      format.html { redirect_to @gig, notice: 'Thanks for signing up!' }
      format.json { render :show, status: :ok, location: @gig }
    end
  end

  def dropout
    @gig.players.delete(@current_member) if @gig.players.include? @current_member
    respond_to do |format|
      format.html { redirect_to @gig, alert: "Awww sorry you can't make it!" }
      format.json { render :show, status: :ok, location: @gig }
    end
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end

  def gig_params
    params.require(:gig).permit(:title, :where, :when, :band_contact, :event_contact,
                                :gig_admin_id, :confirmed, :about, :about_r, :signup, :dropout,
                                :high_payer, :charity)
  end

  def set_presence(val)
    @gig = Gig.find(params[:id])
    gig_presence = @gig.member_presences.where(member: current_member).first_or_create
    gig_presence.update_attribute :will_be_present, val
  end

end

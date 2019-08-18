class GigsController < ApplicationController
  include Availability
  before_action :authenticate_member!, except: [:published_gig, :published_gigs]
  before_action :set_gig, only: [:show, :edit, :update, :destroy, :signup, :dropout]


  def index
    @gigs = Gig.for_member(current_member)
  end

  def show
    calc_availability(@gig)
    presence = @gig.presence_for_member(current_member)
    @status = if presence.nil?
                'Onbekend'
              elsif presence
                'Aangemeld'
              else
                'Afgemeld'
              end
  end

  def new
    @gig_admins = Member.where(gig_admin: true)
    @gig = Gig.new
  end

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

  def published_gigs
    @cms_site = cms_site_from_request
    @gigs = Gig.where(band_id: @cms_site.band_id).published.ascending

  end

  def published_gig
    @cms_site = cms_site_from_request
    @gig = Gig.where(band_id: @cms_site.band_id).find(params[:id])
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

  def cms_site_from_request
    Comfy::Cms::Site.where(hostname: request.host_with_port).first
  end

end

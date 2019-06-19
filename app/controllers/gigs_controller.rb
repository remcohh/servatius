class GigsController < ApplicationController
  before_action :authenticate_member!

  load_and_authorize_resource
  before_action :set_gig, only: [:show, :edit, :update, :destroy, :signup, :dropout]

  # GET /gigs
  # GET /gigs.json
  def index
    @past_gigs = Gig.past
    @future_gigs = Gig.future
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
    query="SELECT instruments.id, instruments.name AS instrument_name, COUNT(CASE WHEN present THEN 1 END) AS COUNT_present, COUNT(CASE WHEN NOT present THEN 1 END) AS COUNT_not_present FROM instruments LEFT OUTER JOIN members ON members.instrument_id=instruments.id
LEFT OUTER JOIN member_presences ON member_presences.member_id = members.id AND member_presences.presentable_id=#{@gig.id} and member_presences.presentable_type='Gig'
GROUP BY instruments.id ORDER BY instruments.id"

    @instruments_availability = ActiveRecord::Base.connection.execute(query)
    @instruments_availability_member = @instruments_availability.find{ |i| i['id'] == current_member.instrument_id }
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

  # POST /gigs
  # POST /gigs.json
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

  # PATCH/PUT /gigs/1
  # PATCH/PUT /gigs/1.json
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

  # DELETE /gigs/1
  # DELETE /gigs/1.json
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

  # Use callbacks to share common setup or constraints between actions.
  def set_gig
    @gig = Gig.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
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

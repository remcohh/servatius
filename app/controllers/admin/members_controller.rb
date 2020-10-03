class Admin::MembersController < ApplicationController
  before_action :authenticate_member!

  # ml=Magic::Link::MagicLink.new
  # ml.email="remcohh@gmail.com"
  # ml.send_login_instructions

  def index
    @filterrific = initialize_filterrific(
        Member,
        params[:filterrific],
        select_options: {
        },
        persistence_id: false,
        default_filter_params: {},
        available_filters: [:sorted_by, :name_filter],
        sanitize_params: true,
    ) || return

    @members = @filterrific.find

  end

  def show
    @member = Member.find params[:id]
    @ensemble_instrument = @member.ensemble_instruments.new
  end

  def edit
    @member = Member.find params[:id]
  end

  def update
    @member = Member.find params[:id]
    @member.update_attributes member_params
    redirect_to action: :index
  end

  def new
    @member = Member.new
  end

  def create
    Member.create(member_params.merge(password: 'jjduuj',
                                      password_confirmation: 'jjduuj',
                                      band_id: current_member.band_id,
    ))
    redirect_to action: :index
  end

  def destroy
    Member.find(params[:id]).destroy!
    redirect_to action: :index
  end

  def send_login_link
    @member = Member.find params[:member_id]
    ml=Magic::Link::MagicLink.new
    ml.email=@member.email
    ml.send_login_instructions
    flash[:notice] = 'Login link verstuurd'
    redirect_to action: :index
  end

  def send_reset_password_link
    @member = Member.find params[:member_id]
    @member.send_reset_password_instructions
    flash[:notice] = 'Instructies verstuurd'
    redirect_to action: :index
  end

  def generate_reset_password_link
    @member = Member.find params[:member_id]
    raw, hashed = Devise.token_generator.generate(Member, :reset_password_token)
    @member.update_attributes reset_password_token: hashed, reset_password_sent_at: Time.now.utc
    @reset_password_url = "http://leden.fanfaresintservatius.nl/members/password/edit?reset_password_token=#{raw}"
    render action: :show
  end

  def generate_password
    @member = Member.find params[:member_id]
    chars = ('0'..'9').to_a + ('a'..'z').to_a
    @password = chars.sort_by { rand }.join[0...5]
    @member.update_attributes password: @password, password_confirmation: @password
    render action: :show

  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :email, ensemble_instrument_ids: [], group_ids: [])
  end

  def ensemble_instrument_params
    params.require(:ensemble_instrument).permit(:ensemble_instrument_id)
  end

end

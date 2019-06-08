class MembersController < ApplicationController
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
        persistence_id: "shared_key",
        default_filter_params: {},
        available_filters: [:sorted_by, :name_filter],
        sanitize_params: true,
    ) || return

    @members = @filterrific.find.page(params[:page])

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
    Member.create(member_params)
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

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :email)
  end
end

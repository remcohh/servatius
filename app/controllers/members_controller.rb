class MembersController < ApplicationController

  # ml=Magic::Link::MagicLink.new
  # ml.email="remcohh@gmail.com"
  # ml.send_login_instructions


  def index
    @members = Member.all
  end


end

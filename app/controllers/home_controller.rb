class HomeController < ApplicationController
  before_action :authenticate_member!

  def index
    @messages = Message.for_member(current_member).first(3)
    @rehearsals = Rehearsal.for_member(current_member).first(3)
  end

end
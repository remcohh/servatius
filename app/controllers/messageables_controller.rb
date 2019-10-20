class MessageablesController < ApplicationController
  before_action :authenticate_member!

  def index
    @messageables = current_member.messageables
  end

end

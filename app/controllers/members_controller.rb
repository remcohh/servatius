class MembersController < ApplicationController
  before_action :authenticate_member!

  def profile
  end

  def edit_password
  end

  def update_password
    if current_member.update_attributes password: params[:password],
                                        password_confirmation: params[:password_confirmation]
      redirect_to app_home_path
    else
      flash[:error] = current_member.errors.collect { |_, v| v }.join(',')
      render action: 'edit_password'
    end
  end

end
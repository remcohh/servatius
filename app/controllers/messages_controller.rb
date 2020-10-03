class MessagesController < ApplicationController
  before_action :authenticate_member!

  def index
    @messages = Message.for_member(current_member)
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    @message.update_attributes message_params
    redirect_to messages_path
  end

  def new
    @message = Message.new
    @messageable = get_messageable(params[:model], params[:id])
  end

  def create
    @messageable = get_messageable(params[:model], params[:id])
    @message = @messageable.messages.create message_params.merge(member_id: current_member.id)
    MemberMailer.notify_message(@message).deliver_now if @message.email_notification

    redirect_to messages_path
  end

  def destroy
    raise "umpermitted action" unless current_member.admin?
    Message.find(params[:id]).destroy!
    redirect_to action: :index
  end

  private

  def message_params
    params.require(:message).permit(:message, :title, :email_notification, :upload)
  end

  def get_messageable(model, id)
    model = model.constantize
    return [] unless model.new.respond_to?(:messages)
    model.find(id)
  end
end

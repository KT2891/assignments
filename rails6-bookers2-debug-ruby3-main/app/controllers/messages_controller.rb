class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.save
    @messages = Message.where(room_id: @message.room_id)
    @room = @message.room
  end

  private
  def message_params
    params.require(:message).permit(:content, :room_id)
  end

end

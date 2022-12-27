class ChatMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    message = ChatMessage.new(message_params)
    message.user_id = current_user.id
    if message.save!
      redirect_to chat_room_path(message.chat_room)
    else
      redirect_to request.referer
    end
  end

  private

    def message_params
      params.require(:chat_message).permit(:chat_room_id, :body)
    end
end

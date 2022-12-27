class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def create
      chat_room=ChatRoom.create
      ChatRoomUser.create(user_id: current_user.id, chat_room_id: chat_room.id)
      ChatRoomUser.create(user_id: params[:format], chat_room_id: chat_room.id)

      redirect_to chat_room_path(chat_room)
  end

  def show
      @chat_room=ChatRoom.find(params[:id])
      @chat_messages=@chat_room.chat_messages.all
      @chat_message=ChatMessage.new
      chat_room_users=@chat_room.chat_room_users
      @another_chat_room_user=chat_room_users.where.not(user_id: current_user.id).first
  end

end

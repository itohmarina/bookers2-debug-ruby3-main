class ChatRoom < ApplicationRecord
  
  has_many :chat_room_users, foreign_key:"chat_room_id"
  has_many :users, through: :chat_room_users
  has_many :chat_messages
  
end

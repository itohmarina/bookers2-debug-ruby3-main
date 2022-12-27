class CreateChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.integer :user_id
      t.integer :chat_room_id
      t.text :body
      t.timestamps
    end
  end
end

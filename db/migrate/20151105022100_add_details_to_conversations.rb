class AddDetailsToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :sender_unread, :integer, default: 0
    add_column :conversations, :recipient_unread, :integer, default: 0
    add_column :conversations, :last_message, :string
  end
end

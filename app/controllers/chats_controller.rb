class ChatsController < ApplicationController
  def index
     @conversations = Conversation.chats(current_user)
    fresh_when(@conversations)
  end

end

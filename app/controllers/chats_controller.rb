class ChatsController < ApplicationController
  def index
     @conversations = Conversation.chats(current_user)
  end
  
end

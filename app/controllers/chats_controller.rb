class ChatsController < ApplicationController
  before_action :authenticate_user!
  
  def index
     # Rails.cache.delete("#{current_user.id}_chats_cache")
     @conversations = Rails.cache.fetch("#{current_user.id}_chats_cache") do
        # redirect_to('http://google.com')
        # return
        conversations = Conversation.chats(current_user)
        Rails.cache.write("#{current_user.id}_chats_cache", conversations)
        conversations
      end
  end

end

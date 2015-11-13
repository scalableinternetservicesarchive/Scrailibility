class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    #set unreader message counter for the message receiver
    if @conversation.sender_id == current_user.id
        unread = @conversation.recipient_unread + 1
        @conversation.update(recipient_unread: unread)
    else
        unread = @conversation.sender_unread + 1
        @conversation.update(sender_unread: unread)
    end
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!
    @conversation.update(last_message: @message.body)
    @path = conversation_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end

class ConversationsController < ApplicationController
	before_action :authenticate_user!

  layout false

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    render json: { conversation_id: @conversation.id }
  end

  def check_new_messages
      @messages_from = Hash.new
      @unread_count = 0
      conversations = Conversation.involving(current_user)
      conversations.each do |conversation|
        if conversation.sender_id == current_user.id && conversation.sender_unread > 0
          @unread_count += conversation.sender_unread
          @messages_from[conversation.recipient_id] = conversation.sender_unread
        elsif conversation.recipient_id == current_user.id && conversation.recipient_unread >0
          @messages_from[conversation.sender_id] = conversation.recipient_unread
          @unread_count += conversation.recipient_unread
        else
        end
      end
  end

  def read_messages
    conversation = Conversation.find(params[:conversation_id])
    if conversation.sender_id == current_user.id
        conversation.sender_unread = 0
    else
        conversation.recipient_unread = 0
    end
    conversation.save!

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end

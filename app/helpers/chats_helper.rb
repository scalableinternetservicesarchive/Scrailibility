module ChatsHelper
  def the_other(conversation)
      if conversation.sender_id == current_user.id
        Profile.find_by user_id: conversation.recipient_id
      else
        Profile.find_by user_id: conversation.sender_id
      end
  end
  
end

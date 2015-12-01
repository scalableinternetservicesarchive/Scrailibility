class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  after_save :update_cache, on: [ :create, :update]

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :involving, -> (user) do
    where("conversations.sender_id =? OR conversations.recipient_id =?",user.id,user.id)
  end

  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  scope :chats, -> (user) do
    involving(user).merge(where("conversations.last_message IS NOT NULL")).order('updated_at DESC')
  end

  protected
    def update_cache
      Rails.cache.delete("#{self.sender_id}_chats_cache")
      Rails.cache.delete("#{self.recipient_id}_chats_cache")
    end
end

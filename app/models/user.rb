class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :profiles, foreign_key: "user_id", dependent: :destroy
  has_many :user_timeslots, foreign_key: "user_id", dependent: :destroy
  has_many :conversations, foreign_key: "sender_id"
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

class User < ActiveRecord::Base
  has_one :profile, foreign_key: "user_id", dependent: :destroy
  has_many :user_timeslots, foreign_key: "user_id", dependent: :destroy
  has_many :timeslots, :through => :user_timeslots
  has_many :conversations, foreign_key: "sender_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

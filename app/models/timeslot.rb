class Timeslot < ActiveRecord::Base
    has_many :user_timeslots, foreign_key: "timeslot_id", dependent: :destroy
    has_many :users, :through => :user_timeslots
end

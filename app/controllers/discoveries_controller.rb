class DiscoveriesController < ApplicationController
	before_filter :authenticate_user!
	#need to change here! currently just show all the registered users
	#how to verify the identify of current user
	def show
		if current_user.profile.nil?
			redirect_to new_profile_path
			return
		end

=begin
		timeslots = current_user.timeslots
		@people = Hash.new
		@people.default = nil
		for timeslot in timeslots
			for user in timeslot.users
				if (!@people[user.id] and user.id != current_user.id)
					@people[user.id] = user.profile
				end
			end
		end
=end

		nearby = Discoveries.instance.findNearbyUsers(current_user.id, 20)
		@people = Hash.new
		@people.default = nil
		for person in nearby
			if (!@people[person.user_id] and person.user_id != current_user.id)
				@people[person.user_id] = person
			end
		end
	end

end

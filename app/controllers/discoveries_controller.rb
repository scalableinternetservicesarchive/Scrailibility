class DiscoveriesController < ApplicationController


	def gym_people
		place_id = params[:place_id]
		@profiles = Profile.gym_people(place_id)
	end
	#need to change here! currently just show all the registered users
	#how to verify the identify of current user
	def show

		if ! current_user
			current_user = User.find(1)
		end

		if current_user.profile.nil?
			redirect_to new_profile_path
			return
		end

		timeslots = current_user.timeslots
		nearby = Discoveries.instance.findNearbyUsers(current_user.profile.id, 20)
		@people = Hash.new
		@people.default = nil
		for timeslot in timeslots
			users = timeslot.users.where(id: nearby).limit(9)
			for user in users
				if (!@people[user.profile.id] and user.profile.id != current_user.profile.id)
					@people[user.profile.id] = user.profile
				end
			end
		end


	end

end

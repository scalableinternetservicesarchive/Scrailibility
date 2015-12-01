class DiscoveriesController < ApplicationController
	before_filter :authenticate_user!


	def gym_people
		place_id = params[:place_id]
		#save/get people's profile into cache
		@profiles = Rails.cache.fetch("profiles_id_of_#{place_id}") do
			profiles = Profile.gym_people_profile(place_id)
			# p_id = Array.new
			# profiles.each do |profile|
			# 	p_id.push(profile.id)
			# end
			# Rails.cache.write("profiles_id_of_#{place_id}", p_id, expires_in: 2.minute)
			# p_id
			profiles
		end
		fresh_when([@profiles])
	end
	#need to change here! currently just show all the registered users
	#how to verify the identify of current user
	def show
		if current_user.profile.nil?
			redirect_to new_profile_path
			return
		end

		timeslots = current_user.timeslots
		nearby = Discoveries.instance.findNearbyUsers(current_user.profile.id, 20)
		@people = Hash.new
		@people.default = nil
		for timeslot in timeslots
			users = timeslot.users.includes(:profile).where(id: nearby).limit(9)
			for user in users
				if (!@people[user.profile.id] and user.profile.id != current_user.profile.id)
					@people[user.profile.id] = user.profile
				end
			end
		end

	end

end

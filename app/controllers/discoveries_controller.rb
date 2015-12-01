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

		nearby = Discoveries.instance.findNearbyUsers(current_user.profile.id, 20)
		@people = Hash.new
		@people.default = nil
		for person in nearby
			if (!@people[person.id] and person.id != current_user.profile.id)
				@people[person.id] = person
			end
		end
	end

end

class DiscoveriesController < ApplicationController
	before_filter :authenticate_user!
	#need to change here! currently just show all the registered users
	#how to verify the identify of current user
  	def show
  		if current_user.profiles.first.nil?
  			redirect_to new_profile_path
  			return
  		end
  		@people = Profile.all
  	end

end

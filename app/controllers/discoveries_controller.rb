class DiscoveriesController < ApplicationController

	#need to change here! currently just show all the registered users
	#how to verify the identify of current user
  	def show
  		@people = Profile.all
  	end

end

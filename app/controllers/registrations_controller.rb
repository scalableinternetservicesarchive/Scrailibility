class RegistrationsController < Devise::RegistrationsController
	protected
=begin
	#if we use email conformation we should use this one
	def after_inactive_sign_up_path_for(resource)
  		sign_in(resource)
    	new_profile_path
  	end
=end
  	def after_sign_up_path_for(resource)
  		sign_in(resource)
    	'/profiles/new' # Or :prefix_to_your_route
  	end
end

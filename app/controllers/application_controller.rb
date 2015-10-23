class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user_id
  	User.find(session[:user_id]).id
	rescue ActiveRecord::RecordNotFound 
		redirect_to(new_user_session_path)
   end
end

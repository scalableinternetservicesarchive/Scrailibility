class GymsController < ApplicationController
  def nearby_gym
    @latitude = current_user.profile.latitude
    @longitude = current_user.profile.longitude
  end

end

class GymsController < ApplicationController
  def nearby_gym
    @latitude = current_user.profile.latitude
    @longitude = current_user.profile.longitude
    fresh_when([@latitude, @longitude])
  end

end

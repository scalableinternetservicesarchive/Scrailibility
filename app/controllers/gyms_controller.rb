class GymsController < ApplicationController
  before_action :authenticate_user!

  def nearby_gym
    @latitude = current_user.profile.latitude
    @longitude = current_user.profile.longitude
    fresh_when([@latitude, @longitude])
  end

end

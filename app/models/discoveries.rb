require 'singleton'

class Discoveries < ActiveRecord::Base
  self.table_name = "profiles"
  include Singleton
  def findNearbyUsers(uid, radius)
=begin
		distance = SELECT * FROM profiles WHERE
				(69.0 * DEGREES(ACOS(COS(RADIANS($latitude))
				* COS(RADIANS(center_lat))
				* COS(RADIANS($longitude) - RADIANS(center_lng))
				+ SIN(RADIANS($latitude))
				* SIN(RADIANS(center_lat))))) < radius
=end
    Rails.logger.debug("debug::ID is: #{uid}")
    @loc = Profile.select("latitude, longitude").find(uid)
    Rails.logger.debug("debug::loc is: #{@loc}")
    @distance = Profile.where("(69.0 * DEGREES(ACOS(COS(RADIANS(latitude))
    * COS(RADIANS(?))
    * COS(RADIANS(longitude) - RADIANS(?))
    + SIN(RADIANS(latitude))
    * SIN(RADIANS(?))))) < ?", @loc['latitude'], @loc['longitude'], @loc['latitude'], radius)
    return @distance
  end
  
end

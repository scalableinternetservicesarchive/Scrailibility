require 'singleton'

class LocationService
  belongs_to :profile
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
    loc = Profiles.select("latitude, longitude").where(:uid.equals => uid)
    distance = Profiles.where("(69.0 * DEGREES(ACOS(COS(RADIANS(latitude))
    * COS(RADIANS(?))
    * COS(RADIANS(longitude) - RADIANS(?))
    + SIN(RADIANS(latitude))
    * SIN(RADIANS(center_lat))))) < ?", loc.latitude, loc.longitude, radius)
    return distance
  end
end

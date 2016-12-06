class WifiApi
  attr_reader :url, :hotspots_data

  All = []

  def initialize(url)
    @url = url
    @hotspots_data = JSON.parse(RestClient.get(url))
  end

  def self.all
    All
  end

  def make_hotspots
    self.hotspots_data.each do |hotspot|
      hs = Hotspots.new
      hotspot.each do |key, value|
        if key == "boro"
          hs.boro = hotspot["boro"]
        end
        if key == "city"
          hs.city = hotspot["city"]
        end
        if key == "type"
          hs.type = hotspot["type"]
        end
        if key == "lon"
          hs.lon = hotspot["lon"]
        end
        if key == "lat"
          hs.lat = hotspot["lat"]
        end
        if key == "ssid"
          hs.ssid = hotspot["ssid"]
        end
        if key == "name"
          hs.name = hotspot["name"]
        end
        if key == "location"
          hs.location = hotspot["location"]
        end
        if key == "remarks"
          hs.remarks = hotspot["remarks"]
        end
      end
    end
  end

  def boro_edit(input)
    if input == "Staten Island"
      edit = "SI"
    elsif input == "Brooklyn"
      edit = "BK"
    elsif input == "Queens"
      edit = "QU"
    elsif input == "Bronx"
      edit = "BX"
    elsif input == "Manhattan"
      edit = "MN"
    end
    edit
  end

  def compare_coor (user_location, hotspot_location)
    lon_difference = user_location.lon - hotspot_location.lon.to_f
    lat_difference = user_location.lat - hotspot_location.lat.to_f
    difference =  lon_difference.abs + lat_difference.abs
    return difference
  end

  def closest_hotspot (user_location)

    names = []
    closest = 10
    wifi = nil
    Hotspots.all.each do |hotspot|
      if self.compare_coor(user_location, hotspot) < closest
        wifi = hotspot
        names.unshift(hotspot)
        closest = self.compare_coor(user_location, hotspot)
      end
    end
    names
  end

end

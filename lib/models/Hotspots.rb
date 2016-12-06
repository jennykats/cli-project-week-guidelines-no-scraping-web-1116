class Hotspots
  attr_accessor :boro, :city, :name, :type, :lon, :lat, :ssid, :location, :remarks

  All = []

  def initialize
    All << self
  end

  def self.all
    All
  end

  def print_hotspot_info
    puts "The closest network to you is: "
    puts "#{self.ssid} "
    puts  "#{self.location}"
    puts "#{self.type}"
    if self.type == "Limited Free"
      puts "#{self.remarks}"
    end
  end

end



class UserLocation
  attr_accessor :text, :lon, :lat

  def initialize(text)
    @text = text
  end

  def input_to_coordinates
    location = Geocoder.search(text)
    self.lat = location[0].data["geometry"]["location"]["lat"]
    self.lon = location[0].data["geometry"]["location"]["lng"]
    puts "Location Found!"
  end

end

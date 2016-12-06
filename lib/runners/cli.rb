class ExampleCLI

  def call
    puts "Welcome to the Wifi Hotspot Finder!"
    print "Please enter your address: "
    input = gets.strip
    locations = UserLocation.new(input)
    locations.input_to_coordinates
    #API call
    app = WifiApi.new("https://data.cityofnewyork.us/resource/jd4g-ks2z.json")
    app.make_hotspots
    closest_hotspot_to_me = app.closest_hotspot(locations)
    index = 0
    closest_hotspot_to_me[index].print_hotspot_info
    while true


      puts "Do you want to see more results? (y/n)"
      new_input = gets.strip.downcase
      if new_input == "y"
        index +=1
        closest_hotspot_to_me[index].print_hotspot_info
      else
        puts "Thanks for using our app!"
        break
      end
      if index == closest_hotspot_to_me.length - 1
        puts "There are no more results..."
        sleep(1)
        puts "Thanks for using our app!"
        break
      end
    end
  end

end

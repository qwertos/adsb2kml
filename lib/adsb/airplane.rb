require 'ruby_kml'


module ADSB
	class Airplane
		
		@@info = [
			:latitude,
			:longitude,
			:last_heard,
			:speed,
			:vert_rate,
			:track,
			:altitude
		]

		@@info.each do |x|
			attr_accessor x
		end

		attr_reader :address

		def info
			return @@info
		end

		def initialize address
			@address = address
			@altitude = "0"
		end

		def merge_with airplane
			if airplane.address != @address then
				return false
			end

			
			@@info.each do |x|
				if ! airplane.send(x).empty? then
					send( x.to_s + "=" , airplane.send(x) )
				end
			end

			return true
		end

		def placemark
			to_return = KML::Placemark.new(
				:name => @address,
				:geometry => KML::Point.new(
					:coordinates => {
						:lat => @latitude,
						:lng => @longitude,
						:alt => @altitude
					}
				),
				:style_url => "#" + @address + "_style"
			)

			return to_return
		end

		def icon url
			to_return = KML::Style.new(
				:id => @address + "_style",
				:icon_style => KML::IconStyle.new(
					:heading => @track,
					:icon => KML::Icon.new(
						:href => url
					),
					:scale => 1.3
				),
				:label_style => KML::LabelStyle.new(
					:scale => 0.7
				)
			)
		end

		def to_cons
			return sprintf $STRING_FORMAT, @address, @latitude, @longitude, @altitude, @speed, @last_heard, time_diff, @track
		end

		def time_diff
			return Time.now.to_i - @last_heard.to_i
		end
			
	end
end


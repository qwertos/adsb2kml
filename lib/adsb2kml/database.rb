
require 'ruby_kml'

module ADSB
	class Database
		attr_accessor :icon_url	

		def initialize name = "ADSB"
			@name = name
			@airplanes = {}
			@icon_url = "/plane_icon.png"
		end


		def update airplane
			if ( @airplanes.has_key? airplane.address ) then
				@airplanes[airplane.address].merge_with airplane
			else
				@airplanes[airplane.address] = airplane
			end
		end

		def update_t airplane
			Thread.new do
				update airplane
			end
		end


		def to_kml
			kml = KMLFile.new
			folder = KML::Folder.new( :name => @name )
			
			@airplanes.each do |address, airplane|
				folder.features << airplane.icon(@icon_url)
				folder.features << airplane.placemark
			end

			kml.objects << folder

			return kml
		end

		def to_cons
			to_return = sprintf $STRING_FORMAT, "Address", "Latitude", "Longitude", "Altitude", "Speed", "Last Heard", "Time Diff", "Track"

			@airplanes.each do |address, air|
				to_return += air.to_cons
			end
			
			return to_return

		end


		def expire_after time = 120
			@time_expire = time
			spawn_thread :watch_expire
		end

		private
		def spawn_thread sym
			Thread.new do
				loop do
					send sym
				end
			end
		end

		def watch_expire
			expired = []
			@airplanes.each do |addr, air|
				if air.time_diff >= @time_expire then
					expired.push addr
				end
			end

			expired.each do |exp|
				@airplanes.delete exp
			end

			sleep 10
		end
	end
end


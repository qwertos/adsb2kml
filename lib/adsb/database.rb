
require 'ruby_kml'

module ADSB
	class Database
		
		def initialize name = "ADSB"
			@name = name
			@airplanes = {}
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
				folder.features << airplane.placemark
				folder.features << airplane.icon
			end

			kml.objects << folder

			return kml
		end

		def to_cons
			to_return = sprintf $STRING_FORMAT, "Address", "Latitude", "Longitude", "Speed", "Last Heard", "Track"

			@airplanes.each do |address, air|
				to_return += air.to_cons
			end
			
			return to_return

		end
	end
end


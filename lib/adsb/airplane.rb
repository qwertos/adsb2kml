

module ADSB
	class Airplane
		
		attr_accessor :latitude, :longitude, :last_heard, :speed, :vert_rate, :track
		attr_reader :address

		def initialize address
			@address = address
		end
	end
end


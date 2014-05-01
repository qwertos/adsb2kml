

module ADSB
	class Airplane
		
		@@info = [
			:latitude,
			:longitude,
			:last_heard,
			:speed,
			:vert_rate,
			:track
		]

		@@info.each do |x|
			attr_accessor x
		end

		attr_reader :address

		def initialize address
			@address = address
		end

		def merge airplane
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
			
	end
end


require 'socket'


module ADSB
	class Listener

		def initialize hostname, port
			@hostname = hostname
			@port = port

			@cons_sock = TCPSocket.new hostname, port
			
			@lt = spawn_thread :listener
		end

		private
		def spawn_thread sym
			Thread.new do
				loop do
					send sym
				end
			end
		end

		def listener
			line = $cons_sock.get.strip

			if ! ( match = $MESSAGE_FORMAT.match line ) then
				return
			end

			timestamp = Time.now.to_i

			info = {
				:address   => match[:address],
				:timestamp => timestamp
				:callsign  => match[:callsign],
				:altitude  => match[:altitude],
				:speed     => match[:speed],
				:track     => match[:track],
				:latitude  => match[:latitude],
				:longitude => match[:longitude],
				:vert_rate => match[:vert_rate]
			}

			
			


		end
	end
end



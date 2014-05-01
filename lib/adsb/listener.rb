require 'socket'


module ADSB
	class Listener

		def initialize hostname, port, database
			@hostname = hostname
			@port = port
			@database = database

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

			temp_airplane = Airplane.new match[:address]

			temp_airplane.last_heard = Time.now.to_i

			temp_airplane.info.each do |sym|
				if sym == :last_heard then
					next
				end

				temp_airplane.send( sym.to_s + "=", match[sym])
			end
			
			@database.update_t( temp_airplane )
		end
	end
end



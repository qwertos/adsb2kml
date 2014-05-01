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
			


		end
	end
end



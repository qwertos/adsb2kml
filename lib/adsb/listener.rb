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
			begin
				line = @cons_sock.gets
			rescue
				puts "error"
			end
			line.strip!

			match = nil
			begin
			if ! ( match = $MESSAGE_FORMAT.match line ) then
				puts "no match"
				return
			end
			rescue
				puts "error2"
			end
			

			temp_airplane = Airplane.new match[:address]

			temp_airplane.last_heard = Time.now.to_i
	

			temp_airplane.info.each do |sym|
			begin
				if sym == :last_heard then
					next
				end

				temp_airplane.send( sym.to_s + "=", match[sym])
			rescue
				puts "error " + sym.to_s
			end
			end
			
			
			
			
			@database.update_t( temp_airplane )
		end
	end
end



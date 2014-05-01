#!/usr/bin/env ruby

require_relative 'config.rb'
require_relative 'lib/adsb.rb'


$db = ADSB::Database.new
$listener = ADSB::Listener.new $HOSTNAME, $PORT, $db
$CLEAR = `clear`


loop do
	puts $CLEAR
	puts $db.to_cons
	sleep 1
end





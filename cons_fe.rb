#!/usr/bin/env ruby

require_relative 'config.rb'
require_relative 'lib/adsb2kml.rb'


$db = ADSB::Database.new
$db.expire_after
$listener = ADSB::Listener.new $HOSTNAME, $PORT, $db
$CLEAR = `clear`


loop do
	print $CLEAR
	puts $db.to_cons
	sleep 1
end





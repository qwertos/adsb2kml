#!/usr/bin/env ruby

require 'sinatra'
require_relative 'config.rb'
require_relative 'lib/adsb.rb'

set :bind => '0.0.0.0'

$db = ADSB::Database.new
#$db.expire_after
$listener = ADSB::Listener.new $HOSTNAME, $PORT, $db



get '/adsb.kml' do
	content_type 'application/vnd.google-earth.kml+xml'
	return $db.to_kml.render
end



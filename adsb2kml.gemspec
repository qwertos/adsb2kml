

Gem::Specification.new do |gem|
	gem.name = "adsb2kml"
	gem.version = '0.0.3'
	gem.license = 'MIT'
	gem.date = Date.today.to_s

	gem.summary = "A library to convert SBS1 messages to KML"
	gem.description = gem.summary

	gem.authors = ["Aaron Herting 'qwertos'"]
	gem.email = 'aaron@herting.cc'
	gem.homepage = 'https://github.com/qwertos/adsb2kml'

	gem.add_dependency 'ruby_kml'

	gem.files = Dir[ 'lib/**/*', 'README.md', 'LICENSE.MIT' ]
end




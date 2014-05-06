#adsb2kml

This is a library to make it easy to view [ADS-B](http://en.wikipedia.org/wiki/Automatic_dependent_surveillance-broadcast)
traffic in [Google Earth](http://earth.google.com).

It was originaly used as part of a presentation at [Imagine RIT](http://www.rit.edu/imagine/) where the data
was merged with [APRS](http://en.wikipedia.org/wiki/Automatic_Packet_Reporting_System) 
traffic from [aprs.fi](http://aprs.fi).

When using the code cloned from the git repository, two basic implementations are included.

`cons_fe.rb` is a basic console front end that looks very similar to the interactive view of dump1090.

`sin_fe.rb` uses sinatra to provide the KML file to Google Earth. This KML file gets regenerated every time
the server gets a new request. 

In either case, a dump1090 server must be availible and serving SBS1 format data (any server providing this
data should work but has only been tested with dump1090). The provided `config.rb.example` file can be copied
to `config.rb` and edited to set the hostname and port number of the server providing this data.




##Dependencies

+	[rtl_sdr](http://sdr.osmocom.org/trac/wiki/rtl-sdr)
+	[dump1090](https://github.com/antirez/dump1090)
+	Gems
	+	[sinatra](http://sinatrarb.com)
	+	[ruby_kml](https://github.com/schleyfox/ruby_kml)

*NOTE: This project does add some files to the module created by ruby_kml.*




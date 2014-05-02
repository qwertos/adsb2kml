

module KML
	class LabelStyle < ColorStyle

		attr_accessor :scale

		def render(xm=Builder::XmlMarkup.new(:indent => 2) )
			xm.LabelStyle {
				super
				xm.scale(scale) unless scale.nil?
			}
		end
	end
end
	

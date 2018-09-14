package arpx.impl.sys.display;

#if arp_display_backend_sys

import arpx.impl.cross.geom.ArpTransform;

@:forward(
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(width:Int, height:Int, transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this = new DisplayContextImpl(width, height, transform, clearColor);
	}
}

#end

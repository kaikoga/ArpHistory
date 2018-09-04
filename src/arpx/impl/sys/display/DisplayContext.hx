package arpx.impl.sys.display;

#if arp_display_backend_sys

import arpx.impl.cross.geom.Transform;

@:forward(
	width, height, clearColor,
	start, display, transform, dupTransform, popTransform, fillRect
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(width:Int, height:Int, transform:Transform = null, clearColor:UInt = 0xff000000) {
		this = new DisplayContextImpl(width, height, transform, clearColor);
	}
}

#end

package arpx.impl.stub.display;

#if arp_display_backend_stub

import arpx.impl.cross.geom.Transform;

@:forward(
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(width:Int, height:Int, transform:Transform = null, clearColor:UInt = 0xff000000) {
		this = new DisplayContextImpl(width, height, transform, clearColor);
	}
}

#end

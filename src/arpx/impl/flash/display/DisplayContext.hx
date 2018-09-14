package arpx.impl.flash.display;

#if arp_display_backend_flash

import flash.display.BitmapData;

import arpx.impl.cross.geom.ArpTransform;

@:forward(
	bitmapData,
	width, height, clearColor,
	renderContext
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(bitmapData:BitmapData, transform:ArpTransform = null, clearColor:UInt = 0xff000000) {
		this = new DisplayContextImpl(bitmapData, transform, clearColor);
	}
}

#end




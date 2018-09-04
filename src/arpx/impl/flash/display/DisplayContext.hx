package arpx.impl.flash.display;

#if (arp_display_backend_flash || arp_display_backend_openfl)

import flash.display.BitmapData;

import arpx.impl.cross.geom.Transform;

@:forward(
	bitmapData,
	width, height, clearColor,
	start, display, transform, dupTransform, popTransform, fillRect
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(bitmapData:BitmapData, transform:Transform = null, clearColor:UInt = 0xff000000) {
		this = new DisplayContextImpl(bitmapData, transform, clearColor);
	}
}

#end




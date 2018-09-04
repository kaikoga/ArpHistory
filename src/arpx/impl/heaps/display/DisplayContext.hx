package arpx.impl.heaps.display;

#if arp_display_backend_heaps

import h2d.Sprite;

import arpx.impl.cross.geom.Transform;

@:forward(
	buf, drawTile,
	width, height, clearColor,
	start, display, transform, dupTransform, popTransform, fillRect
)
abstract DisplayContext(DisplayContextImpl) {
	inline public function new(buf:Sprite, width:Int, height:Int, transform:Transform = null, clearColor:UInt = 0) {
		this = new DisplayContextImpl(buf, width, height, transform, clearColor);
	}
}

#end

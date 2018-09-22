package arpx.impl.heaps.display;

#if arp_display_backend_heaps

@:forward(
	buf, drawTile,
	width, height, clearColor,
	display, transform, dupTransform, popTransform, fillRect
)
abstract RenderContext(DisplayContextImpl) {
	inline public function new(impl:DisplayContextImpl) {
		this = impl;
		this.start();
	}
}

#end
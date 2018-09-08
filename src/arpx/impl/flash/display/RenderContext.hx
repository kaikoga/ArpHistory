package arpx.impl.flash.display;

#if arp_display_backend_flash

@:forward(
	bitmapData,
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




package arpx.impl.sys.display;

#if arp_display_backend_sys

@:forward(
	width, height, clearColor,
	start, display, transform, dupTransform, popTransform, fillRect
)
abstract RenderContext(DisplayContextImpl) {
	inline public function new(impl:DisplayContextImpl) {
		this = impl;
		this.start();
	}
}

#end

package arpx.impl.stub.geom;

#if arp_display_backend_stub

class PointImpl {

	// dummy
	public var x:Float;
	// dummy
	public var y:Float;

	public function new() return;

	inline public static function alloc(x:Float = 0, y:Float = 0) return new PointImpl();
}

#end

package arpx.impl.sys.geom;

#if arp_display_backend_sys

class PointImpl {

	// dummy
	public var x:Float;
	// dummy
	public var y:Float;

	public function new() return;

	inline public static function alloc(x:Float = 0, y:Float = 0) return new PointImpl();

	inline public function transform(matrix:MatrixImpl):Void return;
}

#end

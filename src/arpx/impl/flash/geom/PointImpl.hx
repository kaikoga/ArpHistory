package arpx.impl.flash.geom;

#if arp_display_backend_flash

import flash.geom.Point;

@:forward
abstract PointImpl(Point) from Point {

	public var raw(get, never):Point;
	inline private function get_raw():Point return this;

	inline public function new(raw:Point) this = raw;

	inline public static function alloc(x:Float = 0, y:Float = 0) return new PointImpl(new Point(x, y));
}

#end

package arpx.impl.flash.geom;

#if arp_display_backend_flash

import flash.geom.Matrix;

@:forward
abstract MatrixImpl(Matrix) from Matrix {

	public var raw(get, never):Matrix;
	inline private function get_raw():Matrix return this;

	inline public function new(raw:Matrix) this = raw;
}

#end

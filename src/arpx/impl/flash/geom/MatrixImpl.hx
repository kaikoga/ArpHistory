package arpx.impl.flash.geom;

#if arp_display_backend_flash

import flash.geom.Matrix;

@:forward(tx, ty, concat, translate)
abstract MatrixImpl(Matrix) from Matrix {

	public var raw(get, never):Matrix;
	inline private function get_raw():Matrix return this;

	inline public function new(raw:Matrix) this = raw;

	inline public function reset2d(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Void {
		this.setTo(a, b, c, d, tx, ty);
	}

	inline public function clone(matrix:MatrixImpl):Void {
		this = this.clone();
	}

	inline public function copyFrom(matrix:MatrixImpl):Void {
		this.copyFrom(matrix.raw);
	}

	public var xx(get, set):Float;
	inline private function get_xx():Float return this.a;
	inline private function set_xx(value:Float):Float return this.a = value;

	public var yx(get, set):Float;
	inline private function get_yx():Float return this.b;
	inline private function set_yx(value:Float):Float return this.b = value;

	public var xy(get, set):Float;
	inline private function get_xy():Float return this.c;
	inline private function set_xy(value:Float):Float return this.c = value;

	public var yy(get, set):Float;
	inline private function get_yy():Float return this.d;
	inline private function set_yy(value:Float):Float return this.d = value;

	public var tx(get, set):Float;
	inline private function get_tx():Float return this.tx;
	inline private function set_tx(value:Float):Float return this.tx = value;

	public var ty(get, set):Float;
	inline private function get_ty():Float return this.ty;
	inline private function set_ty(value:Float):Float return this.ty = value;
}

#end

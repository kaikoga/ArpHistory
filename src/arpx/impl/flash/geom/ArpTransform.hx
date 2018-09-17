package arpx.impl.flash.geom;

#if arp_display_backend_flash

import arp.domain.IArpStruct;
import arpx.impl.cross.geom.ArpTransformBase;
import arpx.impl.cross.geom.IArpTransform;
import arpx.impl.cross.geom.MatrixImpl;

@:arpStruct("Transform")
class ArpTransform extends ArpTransformBase implements IArpTransform implements IArpStruct {

	// XXX
	// public var raw(get, never):Matrix;
	// inline private function get_raw():Matrix return impl.raw;

	public function new() super();

	override public function prependTransform(transform:ArpTransform):ArpTransform {
		var matrix:MatrixImpl = transform.impl.clone();
		matrix.concat(this.impl.raw);
		this.impl = matrix;
		return this;
	}

	override public function prependXY(x:Float, y:Float):ArpTransform {
		this.impl.translate(x * this.impl.xx + y * this.impl.yx, x * this.impl.xy + y * this.impl.yy);
		return this;
	}

	override public function appendTransform(transform:ArpTransform):ArpTransform {
		this.impl.concat(transform.impl.raw);
		return this;
	}

	override public function appendXY(x:Float, y:Float):ArpTransform {
		this.impl.translate(x, y);
		return this;
	}
}

#end

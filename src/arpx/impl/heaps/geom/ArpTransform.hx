package arpx.impl.heaps.geom;

#if arp_display_backend_heaps

import arp.domain.IArpStruct;
import arpx.impl.cross.geom.ArpTransformBase;
import arpx.impl.cross.geom.IArpTransform;

@:arpStruct("Transform")
class ArpTransform extends ArpTransformBase implements IArpTransform implements IArpStruct {

	// XXX
	// public var raw(get, never):Matrix;
	// inline private function get_raw():Matrix return impl.raw;

	public function new() super();

	override public function prependTransform(transform:ArpTransform):ArpTransform {
		this.impl.multiply(transform.impl.raw, this.impl.raw);
		return this;
	}

	override public function prependXY(x:Float, y:Float):ArpTransform {
		this.impl.tx += x * this.impl.xx + y * this.impl.yx;
		this.impl.ty += x * this.impl.xy + y * this.impl.yy;
		return this;
	}

	override public function appendTransform(transform:ArpTransform):ArpTransform {
		this.impl.multiply(this.impl.raw, transform.impl.raw);
		return this;
	}

	override public function appendXY(x:Float, y:Float):ArpTransform {
		this.impl.tx += x;
		this.impl.ty += y;
		return this;
	}
}

#end

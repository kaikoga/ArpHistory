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
}

#end

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
}

#end

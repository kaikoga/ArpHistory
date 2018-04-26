package net.kaikoga.arpx.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Matrix;
import flash.geom.Point;

interface ITransform extends IGenericTransform {
	// returns null if some transformation cannot be preserved.
	function asPoint():Point;
	function asMatrix():Matrix;

	// drops some information.
	function toPoint():Point;
	function toMatrix():Matrix;
}

#end

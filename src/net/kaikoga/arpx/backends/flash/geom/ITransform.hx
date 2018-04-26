package net.kaikoga.arpx.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import net.kaikoga.arpx.geom.IGenericTransform;

interface ITransform extends IGenericTransform {
	// returns null if some transformation cannot be preserved.
	function asPoint():APoint;
	function asMatrix():AMatrix;

	// drops some information.
	function toPoint():APoint;
	function toMatrix():AMatrix;
}

#end

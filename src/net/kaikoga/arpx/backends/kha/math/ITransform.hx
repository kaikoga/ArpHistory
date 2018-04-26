package net.kaikoga.arpx.backends.kha.math;

#if arp_backend_kha

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

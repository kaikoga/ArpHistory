package net.kaikoga.arpx.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

import flash.geom.Matrix;
import flash.geom.Point;

interface ITransform {

	function toCopy():ITransform;

	// returns null if some transformation cannot be preserved.
	function asPoint():Point;
	function asMatrix():Matrix;

	// drops some information.
	function toPoint():Point;
	function toMatrix():Matrix;

	// _ prefixed functions modify the instance (or creates a new instance if unable to modify self).
	// overwrites transform.
	function _setXY(x:Float, y:Float):ITransform;
	// appends transform.
	function _concatTransform(transform:ITransform):ITransform;
	function _concatXY(x:Float, y:Float):ITransform;

	// prefixless functions always create a new instance.
	function setXY(x:Float, y:Float):ITransform;
	function concatTransform(transform:ITransform):ITransform;
	function concatXY(x:Float, y:Float):ITransform;
}

#end

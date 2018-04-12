package net.kaikoga.arpx.backends.heaps.math;

#if arp_backend_heaps

import h3d.col.Point;
import h3d.Matrix;

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
	function _setMatrix(matrix:Matrix):ITransform;
	function _setPoint(pt:Point):ITransform;
	function _setXY(x:Float, y:Float):ITransform;
	// appends transform.
	function _concatTransform(transform:ITransform):ITransform;
	function _concatMatrix(matrix:Matrix):ITransform;
	function _concatPoint(pt:Point):ITransform;
	function _concatXY(x:Float, y:Float):ITransform;

	// prefixless functions always create a new instance.
	function setMatrix(matrix:Matrix):ITransform;
	function setPoint(pt:Point):ITransform;
	function setXY(x:Float, y:Float):ITransform;
	function concatTransform(transform:ITransform):ITransform;
	function concatMatrix(matrix:Matrix):ITransform;
	function concatPoint(pt:Point):ITransform;
	function concatXY(x:Float, y:Float):ITransform;
}

#end

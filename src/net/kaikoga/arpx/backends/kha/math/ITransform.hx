package net.kaikoga.arpx.backends.kha.math;

#if arp_backend_kha

import kha.math.Matrix3;
import kha.math.Vector2;

interface ITransform {

	function toCopy():ITransform;

	// returns null if some transformation cannot be preserved.
	function asPoint():Vector2;
	function asMatrix():Matrix3;

	// drops some information.
	function toPoint():Vector2;
	function toMatrix():Matrix3;

	// _ prefixed functions modify the instance (or creates a new instance if unable to modify self).
	// overwrites transform.
	function _setMatrix(matrix:Matrix3):ITransform;
	function _setPoint(pt:Vector2):ITransform;
	function _setXY(x:Float, y:Float):ITransform;
	// appends transform.
	function _concatTransform(transform:ITransform):ITransform;
	function _concatMatrix(matrix:Matrix3):ITransform;
	function _concatPoint(pt:Vector2):ITransform;
	function _concatXY(x:Float, y:Float):ITransform;

	// prefixless functions always create a new instance.
	function setMatrix(matrix:Matrix3):ITransform;
	function setPoint(pt:Vector2):ITransform;
	function setXY(x:Float, y:Float):ITransform;
	function concatTransform(transform:ITransform):ITransform;
	function concatMatrix(matrix:Matrix3):ITransform;
	function concatPoint(pt:Vector2):ITransform;
	function concatXY(x:Float, y:Float):ITransform;
}

#end

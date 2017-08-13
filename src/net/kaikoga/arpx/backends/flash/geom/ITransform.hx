package net.kaikoga.arpx.backends.flash.geom;

import flash.display.BlendMode;
import flash.display.DisplayObject;
import flash.geom.Matrix;
import flash.geom.Matrix3D;
import flash.geom.Point;

interface ITransform {

	var blendMode(get, never):BlendMode;

	function toCopy():ITransform;

	// returns null if some transformation cannot be preserved.
	function asPoint():Point;
	function asMatrix():Matrix;
	function asMatrix3D():Matrix3D;

	// drops some information.
	function toPoint():Point;
	function toMatrix():Matrix;
	function toMatrix3D():Matrix3D;

	function applyTo(target:DisplayObject):Void;

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


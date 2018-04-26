package net.kaikoga.arpx.geom;

interface ITransform {
	// returns null if some transformation cannot be preserved.
	function asPoint():APoint;
	function asMatrix():AMatrix;

	// drops some information.
	function toPoint():APoint;
	function toMatrix():AMatrix;

	function toCopy():ITransform;

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

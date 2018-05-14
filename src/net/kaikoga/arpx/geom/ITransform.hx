package net.kaikoga.arpx.geom;

interface ITransform {
	// trys to convert to impl representations, but returns null if some transformation cannot be preserved.
	function asPoint():PointImpl;
	function asMatrix():MatrixImpl;

	// converts to impl representations, may drop some information.
	function toPoint():PointImpl;
	function toMatrix():MatrixImpl;

	// creates an exact copy, includes actual concrete representation used.
	function toCopy():Transform;

	// overwrites transform.
	function setXY(x:Float, y:Float):Transform;

	// modifies transform.
	function appendTransform(transform:Transform):Transform;
	function appendXY(x:Float, y:Float):Transform;
}

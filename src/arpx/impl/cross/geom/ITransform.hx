package arpx.impl.cross.geom;

interface ITransform {
	// creates an exact copy, includes actual concrete representation used.
	function clone():Transform;
	// load value from Transform.
	function copyFrom(source:Transform):Transform;

	// convert from impl representations, preserving all information.
	function readPoint(pt:PointImpl):Transform;
	function readMatrix(matrix:MatrixImpl):Transform;

	// trys to convert to impl representations, but returns null if some transformation cannot be preserved.
	function asPoint(pt:PointImpl = null):PointImpl;

	// converts to impl representations, may drop some information.
	function toPoint(pt:PointImpl = null):PointImpl;

	// overwrites transform.
	function setXY(x:Float, y:Float):Transform;

	// modifies transform.
	function appendTransform(transform:Transform):Transform;
	function appendXY(x:Float, y:Float):Transform;
}

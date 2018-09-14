package arpx.impl.cross.geom;

interface IArpTransform {
	// creates an exact copy, includes actual concrete representation used.
	function clone():ArpTransform;
	// load value from Transform.
	function copyFrom(source:ArpTransform):ArpTransform;

	// overwrites full data.
	function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):ArpTransform;

	// convert from impl representations, preserving all information.
	function readData(data:Array<Float>):ArpTransform;
	function readPoint(pt:PointImpl):ArpTransform;
	function readMatrix(matrix:MatrixImpl):ArpTransform;

	// trys to convert to impl representations, but returns null if some transformation cannot be preserved.
	function asPoint(pt:PointImpl = null):PointImpl;

	// converts to impl representations, may or may not drop some information. Return value is ensured to be not null.
	function toPoint(pt:PointImpl = null):PointImpl;
	function toData(data:Array<Float> = null):Array<Float>;

	// overwrites transform.
	function setXY(x:Float, y:Float):ArpTransform;

	// modifies transform.
	function prependTransform(transform:ArpTransform):ArpTransform;
	function prependXY(x:Float, y:Float):ArpTransform;
	function appendTransform(transform:ArpTransform):ArpTransform;
	function appendXY(x:Float, y:Float):ArpTransform;
}

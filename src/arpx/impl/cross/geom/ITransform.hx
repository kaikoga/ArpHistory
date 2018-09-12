package arpx.impl.cross.geom;

interface ITransform {
	// creates an exact copy, includes actual concrete representation used.
	function clone():Transform;
	// load value from Transform.
	function copyFrom(source:Transform):Transform;

	// overwrites full data.
	function reset(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0):Transform;

	// convert from impl representations, preserving all information.
	function readData(data:Array<Float>):Transform;
	function readPoint(pt:PointImpl):Transform;
	function readMatrix(matrix:MatrixImpl):Transform;

	// trys to convert to impl representations, but returns null if some transformation cannot be preserved.
	function asPoint(pt:PointImpl = null):PointImpl;

	// converts to impl representations, may or may not drop some information. Return value is ensured to be not null.
	function toPoint(pt:PointImpl = null):PointImpl;
	function toData(data:Array<Float> = null):Array<Float>;

	// overwrites transform.
	function setXY(x:Float, y:Float):Transform;

	// modifies transform.
	function appendTransform(transform:Transform):Transform;
	function appendXY(x:Float, y:Float):Transform;
}

package net.kaikoga.arpx.geom;

interface ITransform {
	// trys to convert to concrete representations, but returns null if some transformation cannot be preserved.
	function asPoint():APoint;
	function asMatrix():AMatrix;

	// converts to concrete representations, may drop some information.
	function toPoint():APoint;
	function toMatrix():AMatrix;

	// creates an exact copy, includes actual concrete representation used.
	function toCopy():ITransform;

	// overwrites transform. Creates a new instance if some information may drop.
	function setXY(x:Float, y:Float):ITransform;

	// modifies transform. Creates a new instance if some information may drop.
	function appendTransform(transform:ITransform):ITransform;
	function appendXY(x:Float, y:Float):ITransform;

	// creates a modified instance.
	function concatTransform(transform:ITransform):ITransform;
	function concatXY(x:Float, y:Float):ITransform;
}

package net.kaikoga.arpx.backends.flash.geom;

#if (arp_backend_flash || arp_backend_openfl)

interface IGenericTransform {

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

#end

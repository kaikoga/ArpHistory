package net.kaikoga.arp.structs;

interface IArpParamsRead {
	function getInt(key:String, defaultValue:Int = null):Null<Int>;
	function getFloat(key:String, defaultValue:Float = null):Null<Float>;
	function getString(key:String, defaultValue:String = null):String;
	function getBool(key:String, defaultValue:Bool = null):Null<Bool>;
	function getArpDirection(key:String, defaultValue:ArpDirection = null):ArpDirection;

	function getAsString(key:String, defaultValue:String = null):String;

	function get(key:String):Dynamic;
}


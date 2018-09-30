package arpx.structs.params;

import arp.iterators.EmptyIterator;
import arpx.structs.ArpDirection;

class EmptyArpParams implements IArpParamsRead {

	public function new() return;

	inline public function get(key:String):Dynamic return null;
	inline public function keys():Iterator<String> return new EmptyIterator();

	public function getInt(key:String, defaultValue = null):Null<Int> return defaultValue;
	public function getFloat(key:String, defaultValue = null):Null<Float> return defaultValue;
	public function getString(key:String, defaultValue = null):String return defaultValue;
	public function getBool(key:String, defaultValue = null):Null<Bool> return defaultValue;
	public function getArpDirection(key:String, defaultValue = null):ArpDirection return defaultValue;

	public function getAsString(key:String, defaultValue = null):String return defaultValue;

	public function toString():String return [].join(",");
}

package arpx.structs;

abstract ArpParamsKey(String) from String to String {

	inline public function new(key:String) this = key;

/*
	@:from
	inline public static function fromString(value):ArpParamsKey return new ArpParamsKey(value);

	inline public function toString():String return this;
*/
}

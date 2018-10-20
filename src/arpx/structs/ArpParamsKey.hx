package arpx.structs;

abstract ArpParamsKey(Int) {
	private static var keyMap:Map<String, Int> = new Map<String, Int>();
	private static var keys:Array<String> = [null];

	private static function defineKey(value:String):Int {
		var keyIndex:Int = keys.length;
		keyMap.set(value, keyIndex);
		keys.push(value);
		return keyIndex;
	}

	public var index(get, never):Int;
	private function get_index():Int return this;

	inline public function new(index:Int) this = index;

	@:from
	public static function fromString(value:String):ArpParamsKey {
		return new ArpParamsKey(if (keyMap.exists(value)) keyMap.get(value) else defineKey(value));
	}

	@:to
	public function toString():String return keys[this];
}

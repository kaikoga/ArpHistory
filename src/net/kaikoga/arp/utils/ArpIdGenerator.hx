package net.kaikoga.arp.utils;

abstract ArpIdGenerator(Int) {

	inline public static var AUTO_HEADER:String = "$";
	private static var symbols:Array<String> = [];

	public static var first(get, never):String;
	inline private static function get_first():String return '${AUTO_HEADER}0';

	inline public function new() {
		this = 0;
	}

	inline public function next(prefix:String = null):String {
		var result = symbols[this];
		if (result == null) symbols[this] = result = '${AUTO_HEADER}${Std.string(this)}';
		this++;
		return (prefix == null) ? result : '$prefix$result';
	}

	inline public function reset():Void {
		this = 0;
	}
}

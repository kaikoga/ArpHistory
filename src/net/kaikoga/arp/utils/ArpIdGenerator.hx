package net.kaikoga.arp.utils;

abstract ArpIdGenerator(Int) {

	inline private static var AUTO_HEADER:String = "$";
	private static var symbols:Array<String> = [];

	inline public function new() {
		this = 0;
	}

	inline public function next():String {
		var result = symbols[this];
		if (result == null) symbols[this] = result = '$AUTO_HEADER${Std.string(this)}';
		this++;
		return result;
	}

	inline public function reset():Void {
		this = 0;
	}
}

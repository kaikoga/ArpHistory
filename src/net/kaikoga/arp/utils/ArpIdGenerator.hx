package net.kaikoga.arp.utils;

abstract ArpIdGenerator(Int) {
	inline private static var AUTO_HEADER:String = "$";
	inline public function new() {
		this = 0;
	}
	inline public function next():String {
		return '$AUTO_HEADER${Std.string(this++)}';
	}
	inline public function reset():Void {
		this = 0;
	}
}

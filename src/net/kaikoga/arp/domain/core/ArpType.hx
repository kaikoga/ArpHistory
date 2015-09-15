package net.kaikoga.arp.domain.core;

abstract ArpType(String) {
	inline public function new(value:String) {
		this = value;
	}
	@:to inline public function toString():String {
		return this;
	}
}

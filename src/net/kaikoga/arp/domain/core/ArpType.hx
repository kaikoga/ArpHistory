package net.kaikoga.arp.domain.core;

abstract ArpType(String) {
	public function new(value:String) {
		this = value;
	}
	@:to public function toString():String {
		return this;
	}
}

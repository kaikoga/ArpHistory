package net.kaikoga.arp.domain.core;

abstract ArpDid(String) {
	public function new(value:String) {
		this = value;
	}
	public function toString():String {
		return this;
	}
}

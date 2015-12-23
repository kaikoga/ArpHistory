package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.core.ArpType;

class ArpTypeInfo {

	public var name(default, null):String;
	public var arpType(default, null):ArpType;

	public function isDefault():Bool return name == arpType.toString();

	public function new(name:String, arpType:ArpType) {
		this.name = name;
		this.arpType = arpType;
	}

}

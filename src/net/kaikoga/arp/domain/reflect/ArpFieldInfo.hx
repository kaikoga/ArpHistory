package net.kaikoga.arp.domain.reflect;

import net.kaikoga.arp.domain.core.ArpType;

class ArpFieldInfo {

	public var name(default, null):String;
	public var nativeName(default, null):String;
	public var arpType(default, null):ArpType;
	public var barrier(default, null):Bool;
	
	public function new(name:String, arpType:ArpType, nativeName:String, barrier:Bool) {
		this.name = name;
		this.nativeName = nativeName;
		this.arpType = arpType;
		this.barrier = arpBarrier;
	}

}

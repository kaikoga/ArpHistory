package arp.domain.reflect;

import arp.domain.core.ArpType;

class ArpFieldInfo {

	public var name(default, null):String;
	public var arpType(default, null):ArpType;
	public var fieldKind(default, null):ArpFieldKind;
	public var fieldDs(default, null):ArpFieldDs;
	public var nativeName(default, null):String;
	public var barrier(default, null):Bool;

	public function new(name:String, arpType:ArpType, fieldType:ArpFieldKind, fieldDs:ArpFieldDs, nativeName:String, barrier:Bool) {
		this.name = name;
		this.arpType = arpType;
		this.fieldKind = fieldType;
		this.fieldDs = fieldDs;
		this.nativeName = nativeName;
		this.barrier = barrier;
	}

}

package net.kaikoga.arp.domain.reflect;

class ArpFieldInfo {

	public var name(default, null):String;
	public var fieldType(default, null):ArpFieldType;
	public var fieldDs(default, null):ArpFieldDs;
	public var nativeName(default, null):String;
	public var barrier(default, null):Bool;

	public function new(name:String, fieldType:ArpFieldType, fieldDs:ArpFieldDs, nativeName:String, barrier:Bool) {
		this.name = name;
		this.fieldType = fieldType;
		this.fieldDs = fieldDs;
		this.nativeName = nativeName;
		this.barrier = barrier;
	}

}

package arp.domain.reflect;

import arp.domain.core.ArpType;

class ArpClassInfo {

	public var fieldKind(default, null):ArpFieldKind;
	public var arpType(default, null):ArpType;
	public var fqn(default, null):String;
	public var className(default, null):String;
	public var fields(default, null):Array<ArpFieldInfo>;

	private function new(fieldKind:ArpFieldKind, arpType:ArpType, className:String, fqn:String, fields:Array<ArpFieldInfo>) {
		this.fieldKind = fieldKind;
		this.arpType = arpType;
		this.className = className;
		this.fqn = fqn;
		this.fields = fields;
	}

	public static function reference(arpType:ArpType, className:String, fqn:String, fields:Array<ArpFieldInfo>) {
		return new ArpClassInfo(ArpFieldKind.ReferenceKind, arpType, className, fqn, fields);
	}

	public static function struct(arpType:ArpType, fqn:String) {
		return new ArpClassInfo(ArpFieldKind.StructKind, arpType, null, fqn, null);
	}

	public static function primitive(fieldKind:ArpFieldKind, arpType:ArpType, fqn:String) {
		return new ArpClassInfo(fieldKind, arpType, null, fqn, null);
	}
}

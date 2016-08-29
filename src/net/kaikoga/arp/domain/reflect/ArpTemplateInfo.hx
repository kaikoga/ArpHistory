package net.kaikoga.arp.domain.reflect;

import net.kaikoga.arp.domain.core.ArpType;

class ArpTemplateInfo {

	public var fieldKind(default, null):ArpFieldKind;
	public var arpType(default, null):ArpType;
	public var fqn(default, null):String;
	public var templateName(default, null):String;
	public var fields(default, null):Array<ArpFieldInfo>;

	private function new(fieldKind:ArpFieldKind, arpType:ArpType, templateName:String, fqn:String, fields:Array<ArpFieldInfo>) {
		this.fieldKind = fieldKind;
		this.arpType = arpType;
		this.templateName = templateName;
		this.fqn = fqn;
		this.fields = fields;
	}

	public static function reference(arpType:ArpType, templateName:String, fqn:String, fields:Array<ArpFieldInfo>) {
		return new ArpTemplateInfo(ArpFieldKind.ReferenceKind, arpType, templateName, fqn, fields);
	}

	public static function struct(arpType:ArpType, fqn:String) {
		return new ArpTemplateInfo(ArpFieldKind.StructKind, arpType, null, fqn, null);
	}

	public static function primitive(fieldKind:ArpFieldKind, arpType:ArpType, fqn:String) {
		return new ArpTemplateInfo(fieldKind, arpType, null, fqn, null);
	}
}

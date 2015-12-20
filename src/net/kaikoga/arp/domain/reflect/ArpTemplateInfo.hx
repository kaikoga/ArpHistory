package net.kaikoga.arp.domain.reflect;

import net.kaikoga.arp.domain.core.ArpType;

class ArpTemplateInfo {

	public var arpType(default, null):ArpType;
	public var fields(default, null):Array<ArpFieldInfo>;

	public function new(arpType:ArpType, fields:Array<ArpTypeInfo>) {
		this.arpType = arpType;
		this.fields = fields;
	}

}

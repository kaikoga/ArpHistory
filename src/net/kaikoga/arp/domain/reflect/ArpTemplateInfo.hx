package net.kaikoga.arp.domain.reflect;

import net.kaikoga.arp.domain.core.ArpType;

class ArpTemplateInfo {

	public var arpType(default, null):ArpType;
	public var templateName(default, null):String;
	public var fields(default, null):Array<ArpFieldInfo>;

	public function new(arpType:ArpType, templateName:String, fields:Array<ArpFieldInfo>) {
		this.arpType = arpType;
		this.templateName = templateName;
		this.fields = fields;
	}

}

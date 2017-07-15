package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.domain.reflect.ArpClassInfo;
class MacroArpObject {

	public var classDef(default, null):MacroArpClassDefinition;

	public var arpFields(default, null):Array<IMacroArpField> = [];

	public var templateInfo(default, null):ArpClassInfo;

	public function new(classDef:MacroArpClassDefinition, templateInfo:ArpClassInfo) {
		this.classDef = classDef;
		this.templateInfo = templateInfo;
	}

	public function populateReflectFields():Void {
		for (arpField in this.arpFields) {
			this.templateInfo.fields.push(arpField.toFieldInfo());
		}
	}
}

#end

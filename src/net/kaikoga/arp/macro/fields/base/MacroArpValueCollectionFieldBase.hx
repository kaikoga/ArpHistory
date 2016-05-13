package net.kaikoga.arp.macro.fields.base;

#if macro

import net.kaikoga.arp.macro.IMacroArpValueType;

class MacroArpValueCollectionFieldBase extends MacroArpCollectionFieldBase {

	private var type:IMacroArpValueType;

	private function new(definition:MacroArpFieldDefinition, type:IMacroArpValueType, concreteDs:Bool) {
		super(definition, concreteDs);
		this.type = type;
	}

}

#end

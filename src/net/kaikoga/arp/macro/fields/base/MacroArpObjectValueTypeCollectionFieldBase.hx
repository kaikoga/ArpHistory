package net.kaikoga.arp.macro.fields.base;

#if macro

import net.kaikoga.arp.macro.IMacroArpObjectValueType;

class MacroArpObjectValueTypeCollectionFieldBase extends MacroArpObjectCollectionFieldBase {

	private var type:IMacroArpObjectValueType;

	private function new(definition:MacroArpObjectFieldDefinition, type:IMacroArpObjectValueType, concreteDs:Bool) {
		super(definition, concreteDs);
		this.type = type;
	}

}

#end

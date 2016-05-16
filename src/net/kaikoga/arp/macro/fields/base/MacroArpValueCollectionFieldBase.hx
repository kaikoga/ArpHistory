package net.kaikoga.arp.macro.fields.base;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldType;
import net.kaikoga.arp.macro.IMacroArpValueType;

class MacroArpValueCollectionFieldBase extends MacroArpCollectionFieldBase {

	private var type:IMacroArpValueType;

	override private function get_arpType():String return MacroArpObjectRegistry.arpTypeOf(this.type.nativeType()).toString();
	override private function get_arpFieldType():ArpFieldType return this.type.arpFieldType();

	private function new(definition:MacroArpFieldDefinition, type:IMacroArpValueType, concreteDs:Bool) {
		super(definition, concreteDs);
		this.type = type;
	}

}

#end

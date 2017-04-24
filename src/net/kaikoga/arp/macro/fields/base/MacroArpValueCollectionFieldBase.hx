package net.kaikoga.arp.macro.fields.base;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldKind;
import net.kaikoga.arp.macro.IMacroArpValueType;

class MacroArpValueCollectionFieldBase extends MacroArpCollectionFieldBase {

	private var type:IMacroArpValueType;

	override private function get_arpType():String return MacroArpObjectRegistry.arpTypeOf(this.type.nativeType()).toString();
	override private function get_arpFieldKind():ArpFieldKind return this.type.arpFieldKind();

	private function new(fieldDef:MacroArpFieldDefinition, type:IMacroArpValueType, concreteDs:Bool) {
		super(fieldDef, concreteDs);
		this.type = type;
	}

}

#end

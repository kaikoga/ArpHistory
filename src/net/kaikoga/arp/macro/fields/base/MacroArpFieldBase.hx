package net.kaikoga.arp.macro.fields.base;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.domain.reflect.ArpFieldType;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpFieldInfo;
import haxe.macro.Expr;

class MacroArpFieldBase {

	private var definition:MacroArpFieldDefinition;

	private var nativeField(get, never):Field;
	private function get_nativeField():Field return definition.nativeField;
	private var nativeType(get, never):ComplexType;
	private function get_nativeType():ComplexType return definition.nativeType;

	private var metaArpBarrier(get, never):Bool;
	private function get_metaArpBarrier():Bool return definition.metaArpBarrier;
	private var metaArpField(get, never):String;
	private function get_metaArpField():String return definition.metaArpField;

	private var nativePos(get, never):Position;
	private function get_nativePos():Position return this.nativeField.pos;

	private var iNativeName(get, never):String;
	private function get_iNativeName():String return this.nativeField.name;
	private var iNativeSlot(get, never):String;
	private function get_iNativeSlot():String return this.nativeField.name + "Slot";
	private var i_nativeName(get, never):String;
	private function get_i_nativeName():String return "_" + this.iNativeName;
	private var iGet_nativeName(get, never):String;
	private function get_iGet_nativeName():String return "get_" + this.iNativeName;
	private var iSet_nativeName(get, never):String;
	private function get_iSet_nativeName():String return "set_" + this.iNativeName;

	private var arpType(get, never):String;
	private function get_arpType():String return MacroArpObjectRegistry.arpTypeOf(nativeType).toString();
	private var eArpType(get, never):Expr;
	private function get_eArpType():Expr {
		return macro new net.kaikoga.arp.domain.core.ArpType($v{arpType});
	}
	private var columnName(get, never):String;
	private function get_columnName():String {
		if (metaArpField != null) return metaArpField;
		return iNativeName;
	}

	private var arpFieldType(get, never):ArpFieldType;
	private function get_arpFieldType():ArpFieldType return ArpFieldType.ReferenceType(new ArpType(this.arpType));
	private var arpFieldDs(get, never):ArpFieldDs;
	private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.Scalar;

	private function new(definition:MacroArpFieldDefinition) {
		this.definition = definition;
	}

	@:final public function toFieldInfo():ArpFieldInfo {
		return new ArpFieldInfo(
			this.metaArpField,
			this.arpFieldType,
			this.arpFieldDs,
			this.nativeField.name,
			this.metaArpBarrier
		);
	}
}

#end

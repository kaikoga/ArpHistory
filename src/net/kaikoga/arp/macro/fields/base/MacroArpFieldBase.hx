package net.kaikoga.arp.macro.fields.base;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpFieldInfo;
import haxe.macro.TypeTools;
import haxe.macro.Expr;
import haxe.macro.ComplexTypeTools;

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

	private var iFieldName(get, never):String;
	private function get_iFieldName():String return this.nativeField.name;
	private var i_field(get, never):String;
	private function get_i_field():String return "_" + this.iFieldName;
	private var iGet_field(get, never):String;
	private function get_iGet_field():String return "get_" + this.iFieldName;
	private var iSet_field(get, never):String;
	private function get_iSet_field():String return "set_" + this.iFieldName;

	private var arpType(get, never):String;
	private function get_arpType():String return MacroArpObjectRegistry.arpTypeOf(toFqn(nativeType)).toString();
	private var eArpType(get, never):Expr;
	private function get_eArpType():Expr {
		return macro new net.kaikoga.arp.domain.core.ArpType($v{arpType});
	}
	private var columnName(get, never):String;
	private function get_columnName():String {
		if (metaArpField != null) return metaArpField;
		return iFieldName;
	}
	
	private function new(definition:MacroArpFieldDefinition) {
		this.definition = definition;
	}

	private function toFqn(complexType:ComplexType):String {
		return TypeTools.toString(ComplexTypeTools.toType(complexType));
	}

	public function toFieldInfo():ArpFieldInfo {
		// TODO access ArpType only if this is value type field
		return new ArpFieldInfo(this.metaArpField, null /* new ArpType(this.arpType) */, this.nativeField.name, this.metaArpBarrier);
	}
}

#end

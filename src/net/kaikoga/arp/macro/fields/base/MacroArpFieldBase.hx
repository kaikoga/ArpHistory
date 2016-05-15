package net.kaikoga.arp.macro.fields.base;

#if macro

import haxe.macro.TypeTools;
import haxe.macro.Expr;
import haxe.macro.ComplexTypeTools;

class MacroArpFieldBase {

	private var definition:MacroArpFieldDefinition;

	private var nativeField(get, never):Field;
	private function get_nativeField():Field return definition.nativeField;
	private var nativeType(get, never):ComplexType;
	private function get_nativeType():ComplexType return definition.nativeType;

	private var metaArpValue(get, never):Bool;
	private function get_metaArpValue():Bool return definition.metaArpValue;
	private var metaArpType(get, never):String;
	// private function get_metaArpType():String return definition.metaArpType;
	private function get_metaArpType():String return MacroArpObjectRegistry.arpTypeOf(toFqn(nativeType)).toString();
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

	private var eColumnName(get, never):String;
	private function get_eColumnName():String {
		if (metaArpField != null) return metaArpField;
		return iFieldName;
	}

	private function new(definition:MacroArpFieldDefinition) {
		this.definition = definition;
	}

	private function toFqn(complexType:ComplexType):String {
		return TypeTools.toString(ComplexTypeTools.toType(complexType));
	}
}

#end

package net.kaikoga.arp.macro.fields;

#if macro

import haxe.macro.Expr;

class MacroArpObjectFieldBase {

	private var definition:MacroArpObjectFieldDefinition;

	private var nativeField(get, never):Field;
	private function get_nativeField():Field return definition.nativeField;
	private var nativeType(get, never):ComplexType;
	private function get_nativeType():ComplexType return definition.nativeType;

	private var metaArpField(get, never):Bool;
	private function get_metaArpField():Bool return definition.metaArpField;
	private var metaArpSlot(get, never):ExprOf<String>;
	private function get_metaArpSlot():ExprOf<String> return definition.metaArpSlot;
	private var metaArpBarrier(get, never):Bool;
	private function get_metaArpBarrier():Bool return definition.metaArpBarrier;
	private var metaColumn(get, never):ExprOf<String>;
	private function get_metaColumn():ExprOf<String> return definition.metaColumn;

	private var nativePos(get, never):Position;
	private function get_nativePos():Position return this.nativeField.pos;

	private var iFieldName(get, never):String;
	private function get_iFieldName():String return this.nativeField.name;
	private var iGet_field(get, never):String;
	private function get_iGet_field():String return "get_" + this.iFieldName;
	private var iSet_field(get, never):String;
	private function get_iSet_field():String return "set_" + this.iFieldName;

	private var eColumnName(get, never):ExprOf<String>;
	private function get_eColumnName():ExprOf<String> {
		if (metaColumn != null) {
			return metaColumn;
		} else {
			var iFieldName = this.iFieldName;
			return macro @:pos(this.nativePos) $v{iFieldName};
		}
	}

	private function new(definition:MacroArpObjectFieldDefinition) {
		this.definition = definition;
	}

}

#end

package net.kaikoga.arp.macro.fields;

#if macro

import haxe.macro.Expr;

class MacroArpObjectFieldBase {

	public var nativeField(default, null):Field;
	public var nativeType(default, null):ComplexType;

	private var nativePos(get, never):Position;
	private function get_nativePos():Position return this.nativeField.pos;

	private var iFieldName(get, never):String;
	private function get_iFieldName():String return this.nativeField.name;
	private var iGet_field(get, never):String;
	private function get_iGet_field():String return "get_" + this.iFieldName;
	private var iSet_field(get, never):String;
	private function get_iSet_field():String return "set_" + this.iFieldName;

	private function new(nativeField:Field, nativeType:ComplexType) {
		this.nativeField = nativeField;
		this.nativeType = nativeType;
	}

}

#end

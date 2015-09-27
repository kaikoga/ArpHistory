package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdReferenceMapField;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdListField;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdMapField;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdArrayField;
import net.kaikoga.arp.macro.fields.MacroArpObjectValueField;
import net.kaikoga.arp.macro.fields.MacroArpObjectReferenceField;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ComplexTypeTools;

class MacroArpObjectField {

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

	private static function typeParam(typePath:TypePath, index:Int = 0):ComplexType {
		if (typePath.params == null) throw "invalid type parameter";
		if (typePath.params.length <= index) throw "invalid type parameter";
		switch (typePath.params[index]) {
			case TypeParam.TPType(t): return t;
			case TypeParam.TPExpr(e): throw "invalid type parameter";
		}
	}

	private static function complexTypeToNativeFieldType(complexType:ComplexType):MacroArpObjectNativeFieldType {
		switch (complexType) {
			case ComplexType.TPath(p):
				var fqn:Array<String> = p.pack.copy();
				fqn.push(p.name);
				switch (fqn.join(".")) {
					case "Int":
						return MacroArpObjectNativeFieldType.ValueType(MacroArpObjectValueType.PrimInt);
					case "Float":
						return MacroArpObjectNativeFieldType.ValueType(MacroArpObjectValueType.PrimFloat);
					case "Bool":
						return MacroArpObjectNativeFieldType.ValueType(MacroArpObjectValueType.PrimBool);
					case "String":
						return MacroArpObjectNativeFieldType.ValueType(MacroArpObjectValueType.PrimString);
					case "Array":
						return MacroArpObjectNativeFieldType.StdArray(complexTypeToNativeFieldType(typeParam(p)));
					case "List":
						return MacroArpObjectNativeFieldType.StdList(complexTypeToNativeFieldType(typeParam(p)));
					case "Map":
						return MacroArpObjectNativeFieldType.StdMap(complexTypeToNativeFieldType(typeParam(p, 1)));
					default:
						return MacroArpObjectNativeFieldType.MaybeReference;
				}
			default:
				return MacroArpObjectNativeFieldType.Invalid;
		}
	}

	public static function fromField(nativeField:Field):MacroArpObjectField {
		var metaArpSlot:ExprOf<String> = null;
		var metaArpField:Bool = false;

		for (meta in nativeField.meta) {
			switch (meta.name) {
				case ":arpSlot": metaArpSlot = meta.params[0];
				case ":arpField": metaArpField = true;
			}
		}

		var nativeType:ComplexType = switch (nativeField.kind) {
			case FieldType.FProp(_, _, n, _): n;
			case FieldType.FVar(n, _): n;
			case FieldType.FFun(_): return null;
		}

		var type:MacroArpObjectValueType;
		switch (complexTypeToNativeFieldType(nativeType)) {
			case MacroArpObjectNativeFieldType.ValueType(p):
				if (!metaArpField) return null;
				if (metaArpSlot != null) Context.error(nativeType.toString() + " must be @:arpField", nativeField.pos);
				return new MacroArpObjectValueField(nativeField, nativeType, p);
			case MacroArpObjectNativeFieldType.MaybeReference:
				if (metaArpField) Context.error(nativeType.toString() + " must be @:arpSlot", nativeField.pos);
				if (metaArpSlot == null) return null;
				return new MacroArpObjectReferenceField(nativeField, nativeType, metaArpSlot);
			case MacroArpObjectNativeFieldType.StdArray(t):
				switch (t) {
					case MacroArpObjectNativeFieldType.ValueType(p):
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(nativeType.toString() + " must be @:arpField", nativeField.pos);
						return new MacroArpObjectStdArrayField(nativeField, nativeType, p);
					case _:
						throw "field type too complex: " + nativeType.toString();
				}
			case MacroArpObjectNativeFieldType.StdList(t):
				switch (t) {
					case MacroArpObjectNativeFieldType.ValueType(p):
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(nativeType.toString() + " must be @:arpField", nativeField.pos);
						return new MacroArpObjectStdListField(nativeField, nativeType, p);
					case _:
				}
			case MacroArpObjectNativeFieldType.StdMap(t):
				switch (t) {
					case MacroArpObjectNativeFieldType.ValueType(p):
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(nativeType.toString() + " must be @:arpField", nativeField.pos);
						return new MacroArpObjectStdMapField(nativeField, nativeType, p);
					case MacroArpObjectNativeFieldType.MaybeReference:
						if (metaArpField) Context.error(nativeType.toString() + " must be @:arpSlot", nativeField.pos);
						if (metaArpSlot == null) return null;
						return new MacroArpObjectStdReferenceMapField(nativeField, nativeType, metaArpSlot);
					case _:
				}
			case MacroArpObjectNativeFieldType.Invalid:
		}
		throw "could not create ArpObjectField: " + nativeType.toString();
	}

	public function buildField(outFields:Array<Field>):Void {
		throw "invalid field type";
	}

	private function buildSlot(outFields:Array<Field>, fieldArpType:ExprOf<String>):Void {
		throw "invalid field type";
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		throw "invalid field type";
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		throw "invalid field type";
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		throw "invalid field type";
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		throw "invalid field type";
	}
}

enum MacroArpObjectNativeFieldType {
	Invalid;
	ValueType(type:MacroArpObjectValueType);
	StdArray(param:MacroArpObjectNativeFieldType);
	StdList(param:MacroArpObjectNativeFieldType);
	StdMap(param:MacroArpObjectNativeFieldType);
	MaybeReference;
}

#end

package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.macro.valueTypes.MacroArpObjectPrimInt;
import net.kaikoga.arp.macro.valueTypes.MacroArpObjectPrimFloat;
import net.kaikoga.arp.macro.valueTypes.MacroArpObjectPrimBool;
import net.kaikoga.arp.macro.valueTypes.MacroArpObjectPrimString;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdReferenceMapField;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdListField;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdMapField;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdArrayField;
import net.kaikoga.arp.macro.fields.MacroArpObjectValueField;
import net.kaikoga.arp.macro.fields.MacroArpObjectReferenceField;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ComplexTypeTools;

class MacroArpObjectFieldBuilder {

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
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectPrimInt());
					case "Float":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectPrimFloat());
					case "Bool":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectPrimBool());
					case "String":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectPrimString());
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

	public static function fromField(nativeField:Field):IMacroArpObjectField {
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

		var type:IMacroArpObjectValueType;
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
}

private enum MacroArpObjectNativeFieldType {
	Invalid;
	ValueType(type:IMacroArpObjectValueType);
	StdArray(param:MacroArpObjectNativeFieldType);
	StdList(param:MacroArpObjectNativeFieldType);
	StdMap(param:MacroArpObjectNativeFieldType);
	MaybeReference;
}

#end

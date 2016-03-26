package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.macro.valueTypes.MacroArpObjectArpStruct;
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
import haxe.macro.Expr;

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
				// ISSUE fqn not recognized
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
					case "ArpArea2d":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpArea2d));
					case "ArpColor":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpColor));
					case "ArpDirection":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpDirection));
					case "ArpHitArea":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpHitArea));
					case "ArpParams":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpParams));
					case "ArpPosition":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpPosition));
					case "ArpRange":
						return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpRange));
					default:
						return MacroArpObjectNativeFieldType.MaybeReference;
				}
			default:
				return MacroArpObjectNativeFieldType.Invalid;
		}
	}

	public static function fromField(nativeField:Field):IMacroArpObjectField {
		var definition:MacroArpObjectFieldDefinition = new MacroArpObjectFieldDefinition(nativeField);
		if (!definition.isValidNativeType()) return null;
		switch (complexTypeToNativeFieldType(definition.nativeType)) {
			case MacroArpObjectNativeFieldType.ValueType(p):
				if (definition.expectValueField()) {
					return new MacroArpObjectValueField(definition, p);
				}
			case MacroArpObjectNativeFieldType.MaybeReference:
				if (definition.expectReferenceField()) {
					return new MacroArpObjectReferenceField(definition);
				}
			case MacroArpObjectNativeFieldType.StdArray(t):
				switch (t) {
					case MacroArpObjectNativeFieldType.ValueType(p):
						if (definition.expectValueField()) {
							return new MacroArpObjectStdArrayField(definition, p);
						}
					case _:
				}
			case MacroArpObjectNativeFieldType.StdList(t):
				switch (t) {
					case MacroArpObjectNativeFieldType.ValueType(p):
						if (definition.expectValueField()) {
							return new MacroArpObjectStdListField(definition, p);
						}
					case _:
				}
			case MacroArpObjectNativeFieldType.StdMap(t):
				switch (t) {
					case MacroArpObjectNativeFieldType.ValueType(p):
						if (definition.expectValueField()) {
							return new MacroArpObjectStdMapField(definition, p);
						}
					case MacroArpObjectNativeFieldType.MaybeReference:
						if (definition.expectReferenceField()) {
							return new MacroArpObjectStdReferenceMapField(definition);
						}
					case _:
				}
			case MacroArpObjectNativeFieldType.Invalid:
		}
		definition.expectPlainField();
		return null;
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

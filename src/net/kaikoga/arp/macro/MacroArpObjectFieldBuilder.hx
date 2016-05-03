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
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class MacroArpObjectFieldBuilder {

	private static function typeParam(typePath:TypePath, index:Int = 0):ComplexType {
		if (typePath.params == null) throw "invalid type parameter";
		if (typePath.params.length <= index) throw "invalid type parameter";
		switch (typePath.params[index]) {
			case TypeParam.TPType(t): return t;
			case TypeParam.TPExpr(e): throw "invalid type parameter";
		}
	}

	private static function fqnToNativeFieldType(fqn:Array<String>, typePath:TypePath, pos:Position):Null<MacroArpObjectNativeFieldType> {
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
				return MacroArpObjectNativeFieldType.StdArray(complexTypeToNativeFieldType(typeParam(typePath), pos));
			case "List":
				return MacroArpObjectNativeFieldType.StdList(complexTypeToNativeFieldType(typeParam(typePath), pos));
			case "Map", "Map.IMap", "haxe.Constraints.IMap":
				return MacroArpObjectNativeFieldType.StdMap(complexTypeToNativeFieldType(typeParam(typePath, 1), pos));
			case "net.kaikoga.arp.structs.ArpArea2d":
				return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpArea2d));
			case "net.kaikoga.arp.structs.ArpColor":
				return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpColor));
			case "net.kaikoga.arp.structs.ArpDirection":
				return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpDirection));
			case "net.kaikoga.arp.structs.ArpHitArea":
				return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpHitArea));
			case "net.kaikoga.arp.structs.ArpParams":
				return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpParams));
			case "net.kaikoga.arp.structs.ArpPosition":
				return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpPosition));
			case "net.kaikoga.arp.structs.ArpRange":
				return MacroArpObjectNativeFieldType.ValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpRange));
			default:
				return null;
		}
	}

	private static function complexTypeToNativeFieldType(complexType:ComplexType, pos:Position):MacroArpObjectNativeFieldType {
		var typePath:TypePath;
		switch (complexType) {
			case ComplexType.TPath(p):
				typePath = p;
			default:
				return MacroArpObjectNativeFieldType.Invalid;
		}

		var type:haxe.macro.Type;
		var fqn:Array<String>;
		try {
			type = Context.resolveType(complexType, pos);
			type = Context.follow(type);
		}

		var result:MacroArpObjectNativeFieldType = null;
		switch (type) {
			case haxe.macro.Type.TInst(classRef, params):
				var classType:ClassType = classRef.get();
				fqn = classType.pack.copy();
				fqn.push(classType.name);
				result = fqnToNativeFieldType(fqn, typePath, pos);
				if (result != null) return result;
				// TODO follow super class and interface
				return MacroArpObjectNativeFieldType.MaybeReference;
			case haxe.macro.Type.TAbstract(abstractRef, params):
				var abstractType:AbstractType = abstractRef.get();
				fqn = abstractType.pack.copy();
				fqn.push(abstractType.name);
				result = fqnToNativeFieldType(fqn, typePath, pos);
				if (result != null) return result;
				// TODO follow abstract
				return MacroArpObjectNativeFieldType.MaybeReference;
			case haxe.macro.Type.TType(typeRef, params):
				// TODO follow typedef
				return MacroArpObjectNativeFieldType.MaybeReference;
			default:
		}
		return MacroArpObjectNativeFieldType.Invalid;
	}

	public static function fromDefinition(definition:MacroArpObjectFieldDefinition):IMacroArpObjectField {
		if (!definition.isValidNativeType()) return null;
		switch (complexTypeToNativeFieldType(definition.nativeType, definition.nativeField.pos)) {
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

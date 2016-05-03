package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Printer;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectReferenceSetField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectReferenceListField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectReferenceOmapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectReferenceMapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectOmapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectMapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectListField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectSetField;
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

	private var definition:MacroArpObjectFieldDefinition;

	private var pos:Position;

	private function new(definition:MacroArpObjectFieldDefinition) {
		this.definition = definition;
		this.pos = definition.nativeField.pos;
	}

	private function typeParam(typePath:TypePath, index:Int = 0):ComplexType {
		try {
			if (typePath.params == null) throw "invalid type parameter";
			if (typePath.params.length <= index) throw "invalid type parameter";
			switch (typePath.params[index]) {
				case TypeParam.TPType(t): return t;
				case TypeParam.TPExpr(e): throw "invalid type parameter";
			}
		} catch (e:String) {
			throw "invalid type parameter " + new Printer().printTypePath(typePath);
		}
	}

	private function fqnToNativeFieldType(fqn:Array<String>, typePath:TypePath):Null<MacroArpObjectNativeFieldType> {
		switch (fqn.join(".")) {
			case "Int":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectPrimInt());
			case "Float":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectPrimFloat());
			case "Bool":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectPrimBool());
			case "String":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectPrimString());
			case "Array":
				return MacroArpObjectNativeFieldType.NativeStdArray(complexTypeToNativeFieldType(typeParam(typePath)));
			case "List":
				return MacroArpObjectNativeFieldType.NativeStdList(complexTypeToNativeFieldType(typeParam(typePath)));
			case "Map", "Map.IMap", "haxe.Constraints.IMap":
				return MacroArpObjectNativeFieldType.NativeStdMap(complexTypeToNativeFieldType(typeParam(typePath, 1)));
			case "net.kaikoga.arp.ds.ISet", "net.kaikoga.arp.ds.impl.ArraySet", "net.kaikoga.arp.domain.ds.ArpObjectSet":
				return MacroArpObjectNativeFieldType.NativeDsISet(complexTypeToNativeFieldType(typeParam(typePath)));
			case "net.kaikoga.arp.ds.IList", "net.kaikoga.arp.ds.impl.ArrayList", "net.kaikoga.arp.domain.ds.ArpObjectList":
				return MacroArpObjectNativeFieldType.NativeDsIList(complexTypeToNativeFieldType(typeParam(typePath)));
			case "net.kaikoga.arp.ds.IMap", "net.kaikoga.arp.ds.impl.StdMap", "net.kaikoga.arp.domain.ds.ArpObjectMap":
				return MacroArpObjectNativeFieldType.NativeDsIMap(complexTypeToNativeFieldType(typeParam(typePath, 1)));
			case "net.kaikoga.arp.ds.IOmap", "net.kaikoga.arp.ds.impl.StdOmap", "net.kaikoga.arp.domain.ds.ArpObjectOmap":
				return MacroArpObjectNativeFieldType.NativeDsIOmap(complexTypeToNativeFieldType(typeParam(typePath, 1)));
			case "net.kaikoga.arp.structs.ArpArea2d":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpArea2d));
			case "net.kaikoga.arp.structs.ArpColor":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpColor));
			case "net.kaikoga.arp.structs.ArpDirection":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpDirection));
			case "net.kaikoga.arp.structs.ArpHitArea":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpHitArea));
			case "net.kaikoga.arp.structs.ArpParams":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpParams));
			case "net.kaikoga.arp.structs.ArpPosition":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpPosition));
			case "net.kaikoga.arp.structs.ArpRange":
				return MacroArpObjectNativeFieldType.NativeValueType(new MacroArpObjectArpStruct(macro :net.kaikoga.arp.structs.ArpRange));
			default:
				return null;
		}
	}

	private function complexTypeToNativeFieldType(complexType:ComplexType):MacroArpObjectNativeFieldType {
		var typePath:TypePath;
		switch (complexType) {
			case ComplexType.TPath(p):
				typePath = p;
			default:
				return MacroArpObjectNativeFieldType.NativeInvalid;
		}

		var type:haxe.macro.Type;
		var fqn:Array<String>;
		try {
			type = Context.resolveType(complexType, this.pos);
			type = Context.follow(type);
		}

		var result:MacroArpObjectNativeFieldType = null;
		switch (type) {
			case haxe.macro.Type.TInst(classRef, params):
				var classType:ClassType = classRef.get();
				fqn = classType.pack.copy();
				fqn.push(classType.name);
				result = fqnToNativeFieldType(fqn, typePath);
				if (result != null) return result;
				// TODO follow super class and interface
				return MacroArpObjectNativeFieldType.NativeMaybeReference(complexType);
			case haxe.macro.Type.TAbstract(abstractRef, params):
				var abstractType:AbstractType = abstractRef.get();
				fqn = abstractType.pack.copy();
				fqn.push(abstractType.name);
				result = fqnToNativeFieldType(fqn, typePath);
				if (result != null) return result;
				// TODO follow abstract
				return MacroArpObjectNativeFieldType.NativeMaybeReference(complexType);
			case haxe.macro.Type.TType(typeRef, params):
				// TODO follow typedef
				return MacroArpObjectNativeFieldType.NativeMaybeReference(complexType);
			default:
		}
		return MacroArpObjectNativeFieldType.NativeInvalid;
	}

	private function run():IMacroArpObjectField {
		if (!this.definition.isValidNativeType()) return null;

		var complexType:ComplexType = this.definition.nativeType;
		var pos:Position = this.definition.nativeField.pos;
		var nativeFieldType:MacroArpObjectNativeFieldType = complexTypeToNativeFieldType(complexType);

		switch (nativeFieldType) {
			case MacroArpObjectNativeFieldType.NativeValueType(p):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectValueField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeMaybeReference(p):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectReferenceField(this.definition);
				}
			case MacroArpObjectNativeFieldType.NativeStdArray(MacroArpObjectNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectStdArrayField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeStdList(MacroArpObjectNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectStdListField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeStdMap(MacroArpObjectNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectStdMapField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeStdMap(MacroArpObjectNativeFieldType.NativeMaybeReference(p)):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectStdReferenceMapField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsISet(MacroArpObjectNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectSetField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsISet(MacroArpObjectNativeFieldType.NativeMaybeReference(p)):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectReferenceSetField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsIList(MacroArpObjectNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectListField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsIList(MacroArpObjectNativeFieldType.NativeMaybeReference(p)):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectReferenceListField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsIMap(MacroArpObjectNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectMapField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsIMap(MacroArpObjectNativeFieldType.NativeMaybeReference(p)):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectReferenceMapField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsIOmap(MacroArpObjectNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpObjectOmapField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeDsIOmap(MacroArpObjectNativeFieldType.NativeMaybeReference(p)):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectReferenceOmapField(this.definition, p);
				}
			case MacroArpObjectNativeFieldType.NativeInvalid:
			case _:
		}
		this.definition.expectPlainField();
		return null;
	}

	public static function fromDefinition(definition:MacroArpObjectFieldDefinition):IMacroArpObjectField {
		return new MacroArpObjectFieldBuilder(definition).run();
	}
}

private enum MacroArpObjectNativeFieldType {
	NativeInvalid;
	NativeValueType(type:IMacroArpObjectValueType);
	NativeStdArray(param:MacroArpObjectNativeFieldType);
	NativeStdList(param:MacroArpObjectNativeFieldType);
	NativeStdMap(param:MacroArpObjectNativeFieldType);
	NativeDsISet(param:MacroArpObjectNativeFieldType);
	NativeDsIList(param:MacroArpObjectNativeFieldType);
	NativeDsIMap(param:MacroArpObjectNativeFieldType);
	NativeDsIOmap(param:MacroArpObjectNativeFieldType);
	NativeMaybeReference(contentNativeType:ComplexType);
}

#end

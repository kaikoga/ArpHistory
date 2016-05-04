package net.kaikoga.arp.macro;

#if macro

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
import haxe.macro.TypeTools;
import haxe.macro.Printer;

class MacroArpObjectFieldBuilder {

	private var definition:MacroArpObjectFieldDefinition;

	private var pos:Position;

	private function new(definition:MacroArpObjectFieldDefinition) {
		this.definition = definition;
		this.pos = definition.nativeField.pos;
	}

	private function typeParam(type:Type, index:Int = 0):Type {
		try {
			switch (type) {
				case
					Type.TEnum(_, params),
					Type.TInst(_, params),
					Type.TType(_, params),
					Type.TAbstract(_, params):
					if (params.length <= index) throw "invalid type";
					return params[index];
				case _: throw "invalid type";
			}
		} catch (e:String) {
			throw "invalid type" + new Printer().printComplexType(TypeTools.toComplexType(type));
		}
	}

	private function fqnToNativeFieldType(fqn:Array<String>, type:Type):Null<MacroArpObjectNativeFieldType> {
		this.log("fqn=" + fqn.join("."));
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
				return MacroArpObjectNativeFieldType.NativeStdArray(typeToNativeFieldType(typeParam(type)));
			case "List":
				return MacroArpObjectNativeFieldType.NativeStdList(typeToNativeFieldType(typeParam(type)));
			case "haxe.IMap", "haxe.Constraints.IMap":
				return MacroArpObjectNativeFieldType.NativeStdMap(typeToNativeFieldType(typeParam(type, 1)));
			case "net.kaikoga.arp.ds.ISet":
				return MacroArpObjectNativeFieldType.NativeDsISet(typeToNativeFieldType(typeParam(type)));
			case "net.kaikoga.arp.ds.IList":
				return MacroArpObjectNativeFieldType.NativeDsIList(typeToNativeFieldType(typeParam(type)));
			case "net.kaikoga.arp.ds.IMap":
				return MacroArpObjectNativeFieldType.NativeDsIMap(typeToNativeFieldType(typeParam(type, 1)));
			case "net.kaikoga.arp.ds.IOmap":
				return MacroArpObjectNativeFieldType.NativeDsIOmap(typeToNativeFieldType(typeParam(type, 1)));
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
			case "net.kaikoga.arp.domain.IArpObject":
				return MacroArpObjectNativeFieldType.NativeMaybeReference(TypeTools.toComplexType(type));
			default:
				return null;
		}
	}

	private function baseTypeToNativeFieldType(type:Type, baseType:Type):MacroArpObjectNativeFieldType {
		var result:MacroArpObjectNativeFieldType = null;
		var fqn:Array<String>;
		switch (baseType) {
			case Type.TInst(classRef, params):
				var classType:ClassType = classRef.get();
				fqn = classType.pack.copy();
				fqn.push(classType.name);
				result = fqnToNativeFieldType(fqn, type);
				if (result != null) return result;
				// follow super class and interfaces
				if (classType.superClass != null) {
					var superClassType:Type = Type.TInst(classType.superClass.t, classType.superClass.params);
					this.log("extends=" + Std.string(superClassType));
					result = baseTypeToNativeFieldType(type, superClassType);
					if (result != null) return result;
				}
				for (intf in classType.interfaces) {
					var interfaceType:Type = Type.TInst(intf.t, intf.params);
					this.log("implements=" + Std.string(interfaceType));
					result = baseTypeToNativeFieldType(type, interfaceType);
					if (result != null) return result;
				}
			case Type.TAbstract(abstractRef, params):
				var abstractType:AbstractType = abstractRef.get();
				fqn = abstractType.pack.copy();
				fqn.push(abstractType.name);
				result = fqnToNativeFieldType(fqn, type);
				if (result != null) return result;
				// follow underlying type
				this.log("underlying=" + Std.string(abstractType.type));
				result = baseTypeToNativeFieldType(type, abstractType.type);
				if (result != null) return result;
			case Type.TType(defTypeRef, params):
				var defType:DefType = defTypeRef.get();
				// follow underlying type
				this.log("resolve=" + Std.string(defType.type));
				result = baseTypeToNativeFieldType(type, defType.type);
				if (result != null) return result;
			case _:
		}
		return null;
	}

	private function typeToNativeFieldType(type:Type):MacroArpObjectNativeFieldType {
		this.log("Type=" + Std.string(type));
		var result = baseTypeToNativeFieldType(type, type);
		if (result != null) return result;
		return MacroArpObjectNativeFieldType.NativeInvalid;
	}

	private function complexTypeToNativeFieldType(complexType:ComplexType):MacroArpObjectNativeFieldType {
		// we have to follow types in typed universe
		var type:Type = Context.resolveType(complexType, this.pos);
		return typeToNativeFieldType(type);
	}

	private function doRun():IMacroArpObjectField {
		if (!this.definition.isValidNativeType()) return null;
		this.log("ComplexType=" + new Printer().printComplexType(this.definition.nativeType));

		var complexType:ComplexType = this.definition.nativeType;
		var pos:Position = this.definition.nativeField.pos;
		var nativeFieldType:MacroArpObjectNativeFieldType = complexTypeToNativeFieldType(complexType);

		this.log("NativeType=" + Std.string(nativeFieldType));

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

	private function run():IMacroArpObjectField {
		this.log("field: " + definition.nativeField.name);
		var result = doRun();
		this.log("done: " + definition.nativeField.name);
		return result;
	}

	public static function fromDefinition(definition:MacroArpObjectFieldDefinition):IMacroArpObjectField {
		return new MacroArpObjectFieldBuilder(definition).run();
	}

	inline private function log(message:String):Void {
		#if arp_macro_verbose
		Context.warning(message, this.definition.nativeField.pos);
		#end
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

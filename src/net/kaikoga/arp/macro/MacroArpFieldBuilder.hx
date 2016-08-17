package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.macro.fields.ds.MacroArpObjectSetField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectListField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectOmapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpObjectMapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpValueOmapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpValueMapField;
import net.kaikoga.arp.macro.fields.ds.MacroArpValueListField;
import net.kaikoga.arp.macro.fields.ds.MacroArpValueSetField;
import net.kaikoga.arp.macro.valueTypes.MacroArpStructType;
import net.kaikoga.arp.macro.valueTypes.MacroArpPrimIntType;
import net.kaikoga.arp.macro.valueTypes.MacroArpPrimFloatType;
import net.kaikoga.arp.macro.valueTypes.MacroArpPrimBoolType;
import net.kaikoga.arp.macro.valueTypes.MacroArpPrimStringType;
import net.kaikoga.arp.macro.fields.std.MacroArpObjectStdMapField;
import net.kaikoga.arp.macro.fields.std.MacroArpValueStdListField;
import net.kaikoga.arp.macro.fields.std.MacroArpValueStdMapField;
import net.kaikoga.arp.macro.fields.std.MacroArpValueStdArrayField;
import net.kaikoga.arp.macro.fields.MacroArpValueField;
import net.kaikoga.arp.macro.fields.MacroArpObjectField;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools;
import haxe.macro.Printer;

class MacroArpFieldBuilder {

	private var definition:MacroArpFieldDefinition;

	private var pos:Position;

	private function new(definition:MacroArpFieldDefinition) {
		this.definition = definition;
		this.pos = definition.nativeField.pos;
	}

	private function typeParam(type:Type, index:Int = 0):Type {
		// TODO handle generic classes?
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
			throw "invalid type " + new Printer().printComplexType(TypeTools.toComplexType(type));
		}
	}

	private function fqnToNativeFieldType(fqn:Array<String>, type:Type, isImpl:Bool):Null<MacroArpNativeFieldType> {
		this.log("fqn=" + fqn.join("."));
		switch (fqn.join(".")) {
			case "Int":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpPrimIntType());
			case "Float":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpPrimFloatType());
			case "Bool":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpPrimBoolType());
			case "String":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpPrimStringType());
			case "Array":
				return MacroArpNativeFieldType.NativeStdArray(typeToNativeFieldType(typeParam(type)));
			case "List":
				return MacroArpNativeFieldType.NativeStdList(typeToNativeFieldType(typeParam(type)));
			case "haxe.IMap", "haxe.Constraints.IMap":
				return MacroArpNativeFieldType.NativeStdMap(typeToNativeFieldType(typeParam(type, 1)), isImpl);
			case "net.kaikoga.arp.ds.ISet":
				return MacroArpNativeFieldType.NativeDsISet(typeToNativeFieldType(typeParam(type)), isImpl);
			case "net.kaikoga.arp.ds.IList":
				return MacroArpNativeFieldType.NativeDsIList(typeToNativeFieldType(typeParam(type)), isImpl);
			case "net.kaikoga.arp.ds.IMap":
				return MacroArpNativeFieldType.NativeDsIMap(typeToNativeFieldType(typeParam(type, 1)), isImpl);
			case "net.kaikoga.arp.ds.IOmap":
				return MacroArpNativeFieldType.NativeDsIOmap(typeToNativeFieldType(typeParam(type, 1)), isImpl);
			case "net.kaikoga.arp.structs.ArpColor":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpStructType(macro :net.kaikoga.arp.structs.ArpColor));
			case "net.kaikoga.arp.structs.ArpDirection":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpStructType(macro :net.kaikoga.arp.structs.ArpDirection));
			case "net.kaikoga.arp.structs.ArpHitArea":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpStructType(macro :net.kaikoga.arp.structs.ArpHitArea));
			case "net.kaikoga.arp.structs.ArpParams":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpStructType(macro :net.kaikoga.arp.structs.ArpParams));
			case "net.kaikoga.arp.structs.ArpPosition":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpStructType(macro :net.kaikoga.arp.structs.ArpPosition));
			case "net.kaikoga.arp.structs.ArpRange":
				return MacroArpNativeFieldType.NativeValueType(new MacroArpStructType(macro :net.kaikoga.arp.structs.ArpRange));
			case "net.kaikoga.arp.domain.IArpObject":
				return MacroArpNativeFieldType.NativeMaybeReference(TypeTools.toComplexType(type));
			default:
				return null;
		}
	}

	private function baseTypeToNativeFieldType(type:Type, baseType:Type):MacroArpNativeFieldType {
		var result:MacroArpNativeFieldType = null;
		var fqn:Array<String>;
		switch (baseType) {
			case Type.TInst(classRef, params):
				var classType:ClassType = classRef.get();
				fqn = classType.pack.copy();
				fqn.push(classType.name);
				result = fqnToNativeFieldType(fqn, type, !classType.isInterface);
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
				result = fqnToNativeFieldType(fqn, type, true);
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

	private function typeToNativeFieldType(type:Type):MacroArpNativeFieldType {
		this.log("Type=" + Std.string(type));
		var result = baseTypeToNativeFieldType(type, type);
		if (result != null) return result;
		return MacroArpNativeFieldType.NativeInvalid;
	}

	private function complexTypeToNativeFieldType(complexType:ComplexType):MacroArpNativeFieldType {
		// we have to follow types in typed universe
		var type:Type = Context.resolveType(complexType, this.pos);
		return typeToNativeFieldType(type);
	}

	private function doRun():IMacroArpField {
		if (!this.definition.isValidNativeType()) return null;
		this.log("ComplexType=" + new Printer().printComplexType(this.definition.nativeType));

		var complexType:ComplexType = this.definition.nativeType;
		var pos:Position = this.definition.nativeField.pos;
		var nativeFieldType:MacroArpNativeFieldType = complexTypeToNativeFieldType(complexType);

		this.log("NativeType=" + Std.string(nativeFieldType));

		switch (nativeFieldType) {
			case MacroArpNativeFieldType.NativeValueType(p):
				if (this.definition.expectValueField()) {
					return new MacroArpValueField(this.definition, p);
				}
			case MacroArpNativeFieldType.NativeMaybeReference(p):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectField(this.definition);
				}
			case MacroArpNativeFieldType.NativeStdArray(MacroArpNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpValueStdArrayField(this.definition, p);
				}
			case MacroArpNativeFieldType.NativeStdList(MacroArpNativeFieldType.NativeValueType(p)):
				if (this.definition.expectValueField()) {
					return new MacroArpValueStdListField(this.definition, p);
				}
			case MacroArpNativeFieldType.NativeStdMap(MacroArpNativeFieldType.NativeValueType(p), isImpl):
				if (this.definition.expectValueField()) {
					return new MacroArpValueStdMapField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeStdMap(MacroArpNativeFieldType.NativeMaybeReference(p), isImpl):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectStdMapField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsISet(MacroArpNativeFieldType.NativeValueType(p), isImpl):
				if (this.definition.expectValueField()) {
					return new MacroArpValueSetField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsISet(MacroArpNativeFieldType.NativeMaybeReference(p), isImpl):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectSetField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsIList(MacroArpNativeFieldType.NativeValueType(p), isImpl):
				if (this.definition.expectValueField()) {
					return new MacroArpValueListField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsIList(MacroArpNativeFieldType.NativeMaybeReference(p), isImpl):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectListField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsIMap(MacroArpNativeFieldType.NativeValueType(p), isImpl):
				if (this.definition.expectValueField()) {
					return new MacroArpValueMapField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsIMap(MacroArpNativeFieldType.NativeMaybeReference(p), isImpl):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectMapField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsIOmap(MacroArpNativeFieldType.NativeValueType(p), isImpl):
				if (this.definition.expectValueField()) {
					return new MacroArpValueOmapField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeDsIOmap(MacroArpNativeFieldType.NativeMaybeReference(p), isImpl):
				if (this.definition.expectReferenceField()) {
					return new MacroArpObjectOmapField(this.definition, p, isImpl);
				}
			case MacroArpNativeFieldType.NativeInvalid:
			case _:
		}
		this.definition.expectPlainField();
		return null;
	}

	private function run():IMacroArpField {
		this.log("field: " + definition.nativeField.name);
		var result = doRun();
		this.log("done: " + definition.nativeField.name);
		return result;
	}

	public static function fromDefinition(definition:MacroArpFieldDefinition):IMacroArpField {
		return new MacroArpFieldBuilder(definition).run();
	}

	inline private function log(message:String):Void {
		#if arp_macro_verbose
		Context.warning(message, this.definition.nativeField.pos);
		#end
	}
}

private enum MacroArpNativeFieldType {
	NativeInvalid;
	NativeValueType(type:IMacroArpValueType);
	NativeStdArray(param:MacroArpNativeFieldType);
	NativeStdList(param:MacroArpNativeFieldType);
	NativeStdMap(param:MacroArpNativeFieldType, isImpl:Bool);
	NativeDsISet(param:MacroArpNativeFieldType, isImpl:Bool);
	NativeDsIList(param:MacroArpNativeFieldType, isImpl:Bool);
	NativeDsIMap(param:MacroArpNativeFieldType, isImpl:Bool);
	NativeDsIOmap(param:MacroArpNativeFieldType, isImpl:Bool);
	NativeMaybeReference(contentNativeType:ComplexType);
}

#end

package net.kaikoga.arp.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

class MacroArpObjectFields {

	private static function typePathToTypeName(typePath:TypePath):String {
		var fqn:Array<String> = typePath.pack.copy();
		fqn.push(typePath.name);
		if (typePath.sub != null) fqn.push(typePath.sub);
		return fqn.join(".");
	}

	public static function createFromField(field:Field):MacroArpObjectField {
		var metaArpSlot:ExprOf<String> = null;
		var metaArpField:Bool = false;

		for (meta in field.meta) {
			switch (meta.name) {
				case ":arpSlot": metaArpSlot = meta.params[0];
				case ":arpField": metaArpField = true;
			}
		}

		var nativeType:ComplexType = switch (field.kind) {
			case FieldType.FProp(_, _, n, _): n;
			case FieldType.FVar(n, _): n;
			case FieldType.FFun(_): return null;
		}

		switch (nativeType) {
			case ComplexType.TPath(p):
				switch (typePathToTypeName(p)) {
					case "Int":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: MacroArpObjectFieldType.PrimInt };
					case "Float":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: MacroArpObjectFieldType.PrimFloat };
					case "Bool":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: MacroArpObjectFieldType.PrimBool };
					case "String":
						if (!metaArpField) return null;
						if (metaArpSlot != null) Context.error(p.name + " must be @:arpField", field.pos);
						return { field: field, nativeType: nativeType, type: MacroArpObjectFieldType.PrimString };
					default:
						if (metaArpField) Context.error(p.name + " must be @:arpSlot", field.pos);
						if (metaArpSlot == null) return null;
						return { field: field, nativeType: nativeType, type: MacroArpObjectFieldType.Reference(metaArpSlot) };
				}
			default:
				throw "could not create ArpObjectField: " + Std.string(nativeType);
		}
	}

}

typedef MacroArpObjectField = {
	field:Field,
	nativeType:ComplexType,
	type:MacroArpObjectFieldType
}

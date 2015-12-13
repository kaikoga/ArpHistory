package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ComplexTypeTools;

class MacroArpObjectFieldDefinition {

	public function isValidNativeType():Bool return this.nativeType != null;

	public var nativeField(default, null):Field;
	public var nativeType(default, null):ComplexType;

	public var metaArpValue:Bool = false;
	public var metaArpSlot:ExprOf<String> = null;
	public var metaArpBarrier:Bool = false;
	public var metaColumn:ExprOf<String> = null;

	public function new(nativeField:Field) {
		this.nativeField = nativeField;

		this.nativeType = switch (nativeField.kind) {
			case FieldType.FProp(_, _, n, _): n;
			case FieldType.FVar(n, _): n;
			case FieldType.FFun(_): null;
		}

		for (meta in nativeField.meta) {
			switch (meta.name) {
				case ":arpSlot": metaArpSlot = meta.params[0];
				case ":arpValue": metaArpValue = true;
				case ":arpBarrier": metaArpBarrier = true;
				case ":arpColumn": metaColumn = meta.params[0];
			}
		}
	}

	public function expectPlainField():Bool {
		if (this.metaArpValue || this.metaArpSlot != null || this.metaArpBarrier || this.metaColumn != null) {
			Context.error("field type too complex: " + this.nativeType.toString(), this.nativeField.pos);
		}
		return true;
	}

	public function expectValueField():Bool {
		if (metaArpSlot != null) Context.error('${this.nativeType.toString()} must be @:arpValue', this.nativeField.pos);
		if (metaArpBarrier) Context.error('@:arpBarrier not available for ${this.nativeType.toString()}', this.nativeField.pos);
		return metaArpValue;
	}

	public function expectReferenceField():Bool {
		if (this.metaArpValue) Context.error('${this.nativeType.toString()} must be @:arpSlot', this.nativeField.pos);
		return this.metaArpSlot != null;
	}
}

#end

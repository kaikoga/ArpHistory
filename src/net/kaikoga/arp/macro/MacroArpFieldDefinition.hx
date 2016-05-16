package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ComplexTypeTools;

class MacroArpFieldDefinition {

	public function isValidNativeType():Bool return this.nativeType != null;

	public var nativeField(default, null):Field;
	public var nativeType(default, null):ComplexType;
	public var nativeDefault(default, null):Expr;

	public var metaArpEnabled:Bool = false;
	public var metaArpBarrier:Bool = false;
	public var metaArpField:String = null;
	public var metaArpInit:String = null;
	public var metaArpHeatUp:String = null;
	public var metaArpHeatDown:String = null;
	public var metaArpDispose:String = null;

	public function new(nativeField:Field) {
		this.nativeField = nativeField;

		switch (nativeField.kind) {
			case FieldType.FProp(_, _, n, d), FieldType.FVar(n, d):
				this.nativeType = n;
				this.nativeDefault = d;
			case FieldType.FFun(_):
				this.nativeType = null;
				this.nativeDefault = null;
		}

		for (meta in nativeField.meta) {
			switch (meta.name) {
				case ":arpField": metaArpEnabled = true; metaArpField = valueOf(meta.params[0]);
				case ":arpBarrier": metaArpBarrier = true;
				case ":arpInit": metaArpInit = nativeField.name;
				case ":arpHeatUp": metaArpHeatUp = nativeField.name;
				case ":arpHeatDown": metaArpHeatDown = nativeField.name;
				case ":arpDispose": metaArpDispose = nativeField.name;
				case ":arpWithoutBackend": Context.warning('Not supported in this backend', nativeField.pos);
				case m if (m.indexOf(":arp") == 0) :
					Context.error('Unsupported arp metadata @' + m, this.nativeField.pos);
				case m if (m.indexOf("arp") == 0) :
					Context.error('Use compile time metadata for arp metadatas; "@:arp", not "@arp".', this.nativeField.pos);
			}
		}
	}

	public function expectPlainField():Bool {
		if (this.metaArpEnabled || this.metaArpBarrier) {
			Context.error("field type too complex: " + this.nativeType.toString(), this.nativeField.pos);
		}
		return true;
	}

	public function expectValueField():Bool {
		if (metaArpBarrier) Context.error('@:arpBarrier not available for ${this.nativeType.toString()}', this.nativeField.pos);
		return this.metaArpEnabled;
	}

	public function expectReferenceField():Bool {
		return this.metaArpEnabled;
	}

	private static function valueOf(expr:ExprOf<String>):String {
		if (expr == null) return null;
		return switch (expr.expr) {
			case ExprDef.EConst(Constant.CString(v)): return v;
			case ExprDef.EConst(Constant.CIdent("null")): return null;
			case _: Context.error("invalid expr", Context.currentPos());
		}
	}
}

#end

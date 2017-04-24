package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ComplexTypeTools;

class MacroArpFieldDefinition {

	public var nativeField(default, null):Field;
	public var nativeType(default, null):ComplexType;
	public var nativeDefault(default, null):Expr;

	// ArpField family
	public var metaArpField:MacroArpMetaArpField = MacroArpMetaArpField.Unmanaged;
	public var metaArpBarrier:Bool = false;
	public var metaArpVolatile:Bool = false;

	// Impl family
	public var metaArpImpl:Bool = false;

	// Unmanaged family
	public var metaArpInit:String = null;
	public var metaArpHeatUp:String = null;
	public var metaArpHeatDown:String = null;
	public var metaArpDispose:String = null;

	private var _family:MacroArpFieldDefinitionFamily = MacroArpFieldDefinitionFamily.ImplicitUnmanaged;
	public var family(get, set):MacroArpFieldDefinitionFamily;
	inline private function get_family():MacroArpFieldDefinitionFamily return _family;
	inline private function set_family(value:MacroArpFieldDefinitionFamily):MacroArpFieldDefinitionFamily {
		switch (_family) {
			case MacroArpFieldDefinitionFamily.ImplicitUnmanaged: _family = value;
			case _: if (!Type.enumEq(value, _family)) throw 'Cannot mix';
		}
		return value;
	}

	public function new(nativeField:Field) {
		this.nativeField = nativeField;

		switch (nativeField.kind) {
			case FieldType.FProp(_, _, n, d), FieldType.FVar(n, d):
				this.nativeType = n;
				this.nativeDefault = d;
			case FieldType.FFun(func):
				this.nativeType = null;
				this.nativeDefault = null;
				if (nativeField.name == "new") {
					this.family = MacroArpFieldDefinitionFamily.Constructor(func);
					return;
				}
		}

		for (meta in nativeField.meta) {
			try {
				switch (meta.name) {
					case ":arpField":
						this.family = MacroArpFieldDefinitionFamily.ArpField;
						this.metaArpField = parseMetaArpField(meta.params[0]);
					case ":arpVolatile":
						this.family = MacroArpFieldDefinitionFamily.ArpField;
						this.metaArpVolatile = true;
					case ":arpBarrier":
						this.family = MacroArpFieldDefinitionFamily.ArpField;
						this.metaArpBarrier = true;
					case ":arpImpl":
						switch (nativeType) {
							case ComplexType.TPath(typePath):
								this.family = MacroArpFieldDefinitionFamily.Impl(typePath);
								this.metaArpImpl = true;
							case _:
								throw "TypePath expected for arpImpl";
						}
					case ":arpInit":
						this.family = MacroArpFieldDefinitionFamily.Unmanaged;
						this.metaArpInit = nativeField.name;
					case ":arpHeatUp":
						this.family = MacroArpFieldDefinitionFamily.Unmanaged;
						this.metaArpHeatUp = nativeField.name;
					case ":arpHeatDown":
						this.family = MacroArpFieldDefinitionFamily.Unmanaged;
						this.metaArpHeatDown = nativeField.name;
					case ":arpDispose":
						this.family = MacroArpFieldDefinitionFamily.Unmanaged;
						this.metaArpDispose = nativeField.name;
					case ":arpWithoutBackend":
						this.family = MacroArpFieldDefinitionFamily.Unmanaged;
						Context.warning('Not supported in this backend', nativeField.pos);
					case m if (m.indexOf(":arp") == 0):
						throw 'Unsupported arp metadata';
					case m if (m.indexOf("arp") == 0):
						throw 'Arp metadata is compile time only';
				}
			} catch (d:Dynamic) {
				Context.error(d + ': @' + meta.name, this.nativeField.pos);
			}
		}
	}

	private function isArpManaged():Bool {
		switch (this.family) {
			case MacroArpFieldDefinitionFamily.ImplicitUnmanaged: return false;
			case MacroArpFieldDefinitionFamily.Unmanaged: return false;
			case _: return true;
		}
	}

	public function arpFieldIsForValue():Bool {
		if (metaArpBarrier) Context.error('@:arpBarrier not available for ${this.nativeType.toString()}', this.nativeField.pos);
		return true;
	}

	public function arpFieldIsForReference():Bool {
		// everything is welcome
		return true;
	}

	private static function parseMetaArpField(expr:ExprOf<String>):MacroArpMetaArpField {
		if (expr == null) return MacroArpMetaArpField.Default;
		return switch (expr.expr) {
			case ExprDef.EConst(Constant.CString(v)): MacroArpMetaArpField.Name(v);
			case ExprDef.EConst(Constant.CIdent("false")): MacroArpMetaArpField.Runtime;
			case ExprDef.EConst(Constant.CIdent("null")): MacroArpMetaArpField.Default;
			case _: Context.error("invalid expr", Context.currentPos());
		}
	}
}

enum MacroArpFieldDefinitionFamily {
	ImplicitUnmanaged;
	Unmanaged;
	ArpField;
	Impl(typePath:TypePath);
	Constructor(func:Function);
}

enum MacroArpMetaArpField {
	Unmanaged;
	Default;
	Name(s:String);
	Runtime;
}
#end

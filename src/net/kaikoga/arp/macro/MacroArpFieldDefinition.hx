package net.kaikoga.arp.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ComplexTypeTools;

class MacroArpFieldDefinition {

	public var nativeField(default, null):Field;
	public var nativeType(default, null):ComplexType;
	public var nativeDefault(default, null):Expr;

	public var nativeName(get, never):String;
	inline private function get_nativeName():String return this.nativeField.name;
	public var nativePos(get, never):Position;
	inline private function get_nativePos():Position return this.nativeField.pos;

	// ArpField family
	public var metaArpField:MacroArpMetaArpField = MacroArpMetaArpField.Unmanaged;
	public var metaArpBarrier:Bool = false;
	public var metaArpVolatile:Bool = false;
	public var metaArpDefault:MacroArpMetaArpDefault = MacroArpMetaArpDefault.Zero;

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
			case _: if (!Type.enumEq(value, _family)) Context.error("Cannot mix", this.nativePos);
		}
		return value;
	}

	public function new(nativeField:Field) {
		this.nativeField = nativeField;

		switch (nativeField.kind) {
			case FieldType.FProp(_, _, n, d), FieldType.FVar(n, d):
				this.nativeType = n;
				this.nativeDefault = d;
				for (meta in nativeField.meta) {
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
						case ":arpDefault":
							this.family = MacroArpFieldDefinitionFamily.ArpField;
							switch (meta.params[0]) {
								case { expr: ExprDef.EConst(CString(s))}:
									this.metaArpDefault = MacroArpMetaArpDefault.Simple(s);
								case _: Context.error("@:arpDefault is too complex", nativeField.pos);
							}
						case ":arpImpl":
							switch (nativeType) {
								case ComplexType.TPath(typePath):
									this.family = MacroArpFieldDefinitionFamily.Impl(typePath);
									this.metaArpImpl = true;
								case _: Context.error("TypePath expected for arpImpl", nativeField.pos);
							}
						case m:
							assertNotInvalidArpMeta(m);
					}
				}
			case FieldType.FFun(func):
				this.nativeType = null;
				this.nativeDefault = null;
				if (nativeField.name == "new") {
					this.family = MacroArpFieldDefinitionFamily.Constructor(func);
					return;
				}
				this.family = MacroArpFieldDefinitionFamily.Unmanaged;
				for (meta in nativeField.meta) {
					switch (meta.name) {
						case ":arpInit":
							this.metaArpInit = nativeField.name;
						case ":arpHeatUp":
							this.metaArpHeatUp = nativeField.name;
						case ":arpHeatDown":
							this.metaArpHeatDown = nativeField.name;
						case ":arpDispose":
							this.metaArpDispose = nativeField.name;
						case ":arpWithoutBackend":
							Context.warning('Not supported in this backend', nativeField.pos);
						case m:
							assertNotInvalidArpMeta(m);
					}
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

	private function assertNotInvalidArpMeta(metaName:String):Void {
		if (metaName.indexOf(":arp") == 0) {
			Context.error('Unsupported arp metadata: @${metaName}', this.nativePos);
		} else if (metaName.indexOf("arp") == 0) {
			Context.error('Arp metadata is compile time only: @${metaName}', this.nativePos);
		}
	}

	public function arpFieldIsForValue():Bool {
		if (metaArpBarrier) {
			Context.error('@:arpBarrier not available for ${this.nativeType.toString()}', this.nativePos);
		}
		return true;
	}

	public function arpFieldIsForReference():Bool {
		// everything is welcome
		return true;
	}

	private function parseMetaArpField(expr:ExprOf<String>):MacroArpMetaArpField {
		if (expr == null) return MacroArpMetaArpField.Default;
		return switch (expr.expr) {
			case ExprDef.EConst(Constant.CString(v)): MacroArpMetaArpField.Name(v);
			case ExprDef.EConst(Constant.CIdent("false")): MacroArpMetaArpField.Runtime;
			case ExprDef.EConst(Constant.CIdent("null")): MacroArpMetaArpField.Default;
			case _: Context.error("invalid expr", this.nativePos);
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

enum MacroArpMetaArpDefault {
	Zero;
	Simple(s:String);
}
#end

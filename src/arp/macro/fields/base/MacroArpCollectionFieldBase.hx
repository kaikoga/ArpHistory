package arp.macro.fields.base;

#if macro

import haxe.macro.Expr;
import haxe.macro.Printer;

class MacroArpCollectionFieldBase extends MacroArpFieldBase {

	private var concreteDs:Bool;

	private function new(fieldDef:MacroArpFieldDefinition, concreteDs:Bool) {
		super(fieldDef);
		this.concreteDs = concreteDs;
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		if (this.fieldDef.nativeDefault == null) {
			initBlock.push(macro @:pos(this.nativePos) { this.$i_nativeName = ${this.createEmptyDs(this.concreteNativeTypePath())}; } );
		}
	}

	private function createEmptyDs(concreteNativeTypePath:TypePath):Expr {
		return macro new $concreteNativeTypePath();
	}

	private function concreteNativeTypePath():TypePath {
		var concreteNativeType:ComplexType = if (this.concreteDs) this.nativeType else guessConcreteNativeType();
		return switch (concreteNativeType) {
			case ComplexType.TPath(p):
				p;
			case _:
				MacroArpUtil.fatal("error", this.nativePos);
		}
	}

	private function guessConcreteNativeType():ComplexType {
		return MacroArpUtil.fatal(new Printer().printComplexType(this.nativeType) + "is not constructable", this.nativePos);
	}
}

#end

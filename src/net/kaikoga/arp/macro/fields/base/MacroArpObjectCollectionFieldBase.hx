package net.kaikoga.arp.macro.fields.base;

#if macro

import haxe.macro.Printer;
import haxe.macro.Expr;

class MacroArpObjectCollectionFieldBase extends MacroArpObjectFieldBase {

	private var concreteDs:Bool;

	private function new(definition:MacroArpObjectFieldDefinition, concreteDs:Bool) {
		super(definition);
		this.concreteDs = concreteDs;
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		if (this.definition.nativeDefault == null) {
			var iFieldName:String = this.iFieldName;
			initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = ${this.createEmptyDs(this.concreteNativeTypePath())}; } );
		}
	}

	private function createEmptyDs(concreteNativeTypePath:TypePath):Expr {
		return macro new $concreteNativeTypePath();
	}

	private function concreteNativeTypePath():TypePath {
		var concreteNativeType:ComplexType = if (this.concreteDs) this.nativeType else guessConcreteNativeType();
		return switch (concreteNativeType) {
			case ComplexType.TPath(p): p;
			case _: throw "error";
		}
	}

	private function guessConcreteNativeType():ComplexType {
		throw new Printer().printComplexType(this.nativeType) + "is not constructable";
	}
}

#end

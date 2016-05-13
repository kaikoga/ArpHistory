package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;
class MacroArpPrimFloatType implements IMacroArpValueType {

	public function new() {
	}

	public function nativeType():ComplexType {
		return macro:Float;
	}

	public function createEmptyVo(pos:Position):Expr {
		return macro @:pos(pos) { 0.0; };
	}

	public function createSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { Std.parseFloat(element.value()); };
	}

	public function readSeedElement(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = Std.parseFloat(element.value()); };
	}

	public function readSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readDouble($v{iFieldName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { output.writeDouble($v{iFieldName}, this.$iFieldName); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

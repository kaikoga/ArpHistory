package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;
class MacroArpPrimBoolType implements IMacroArpValueType {

	public function new() {
	}

	public function nativeType():ComplexType {
		return macro:Bool;
	}

	public function createEmptyVo(pos:Position):Expr {
		return macro @:pos(pos) { false; };
	}

	public function createSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { element.value() == "true"; };
	}

	public function readSeedElement(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = element.value() == "true"; };
	}

	public function readSelf(pos:Position, iFieldName:String, eColumnName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readBool($v{eColumnName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String, eColumnName:String):Expr {
		return macro @:pos(pos) { output.writeBool($v{eColumnName}, this.$iFieldName); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

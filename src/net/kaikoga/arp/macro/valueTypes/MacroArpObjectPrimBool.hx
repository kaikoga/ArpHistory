package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;
class MacroArpObjectPrimBool implements IMacroArpObjectValueType {

	public function new() {
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

	public function readSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readBool($v{iFieldName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { output.writeBool($v{iFieldName}, this.$iFieldName); };
	}
}

#end

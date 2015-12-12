package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;
class MacroArpObjectPrimInt implements IMacroArpObjectValueType {

	public function new() {
	}

	public function createEmptyVo(pos:Position):Expr {
		return macro @:pos(pos) { 0; };
	}

	public function createSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { Std.parseInt(element.value()); };
	}

	public function readSeedElement(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = Std.parseInt(element.value()); };
	}

	public function readSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readInt32(${eColumnName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { output.writeInt32(${eColumnName}, this.$iFieldName); };
	}
}

#end

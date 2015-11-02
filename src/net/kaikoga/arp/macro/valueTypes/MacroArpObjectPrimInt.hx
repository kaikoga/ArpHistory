package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;
class MacroArpObjectPrimInt implements IMacroArpObjectValueType {

	public function new() {
	}

	public function getSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { Std.parseInt(element.value()); };
	}

	public function readSelf(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readInt32($v{iFieldName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { output.writeInt32($v{iFieldName}, this.$iFieldName); };
	}
}

#end
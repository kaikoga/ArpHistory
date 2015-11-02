package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;
class MacroArpObjectPrimFloat implements IMacroArpObjectValueType {

	public function new() {
	}

	public function getSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { Std.parseFloat(element.value()); };
	}

	public function readSelf(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readDouble($v{iFieldName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { output.writeDouble($v{iFieldName}, this.$iFieldName); };
	}
}

#end

package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;
class MacroArpObjectPrimString implements IMacroArpObjectValueType {

	public function new() {
	}

	public function getSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { element.value(); };
	}

	public function readSelf(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readUtf($v{iFieldName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { output.writeUtf($v{iFieldName}, this.$iFieldName); };
	}
}

#end

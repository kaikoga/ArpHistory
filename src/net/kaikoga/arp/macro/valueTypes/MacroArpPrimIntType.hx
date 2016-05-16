package net.kaikoga.arp.macro.valueTypes;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpFieldType;
import haxe.macro.Expr;

class MacroArpPrimIntType implements IMacroArpValueType {

	public function new() {
	}

	public function nativeType():ComplexType {
		return macro:Int;
	}

	public function arpFieldType():ArpFieldType {
		return ArpFieldType.PrimInt(new ArpType("Int"));
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

	public function readSelf(pos:Position, iFieldName:String, columnName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readInt32($v{columnName}); };
	}

	public function writeSelf(pos:Position, iFieldName:String, columnName:String):Expr {
		return macro @:pos(pos) { output.writeInt32($v{columnName}, this.$iFieldName); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

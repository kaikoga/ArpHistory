package net.kaikoga.arp.macro.valueTypes;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpFieldKind;
import haxe.macro.Expr;

class MacroArpPrimBoolType implements IMacroArpValueType {

	public function new() {
	}

	public function nativeType():ComplexType return macro:Bool;
	public function arpFieldKind():ArpFieldKind return ArpFieldKind.PrimBool;
	public function arpType():ArpType return new ArpType("Bool");


	public function createEmptyVo(pos:Position):Expr {
		return macro @:pos(pos) { false; };
	}

	public function createSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { element.value == "true"; };
	}

	public function readSeedElement(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = element.value == "true"; };
	}

	public function createAsPersistable(pos:Position, eName:Expr):Expr {
		return macro @:pos(pos) { input.readBool(${eName}); };
	}

	public function readAsPersistable(pos:Position, eName:Expr, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = input.readBool(${eName}); };
	}

	public function writeAsPersistable(pos:Position, eName:Expr, eValue:Expr):Expr {
		return macro @:pos(pos) { output.writeBool(${eName}, ${eValue}); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

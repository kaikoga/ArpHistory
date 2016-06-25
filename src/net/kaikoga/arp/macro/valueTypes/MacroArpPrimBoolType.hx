package net.kaikoga.arp.macro.valueTypes;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpFieldType;
import haxe.macro.Expr;

class MacroArpPrimBoolType implements IMacroArpValueType {

	public function new() {
	}

	public function nativeType():ComplexType {
		return macro:Bool;
	}

	public function arpFieldType():ArpFieldType {
		return ArpFieldType.PrimBool(new ArpType("Bool"));
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

	public function readSelf(pos:Position, eField:Expr, fieldName:String):Expr {
		return macro @:pos(pos) { ${eField} = input.readBool($v{fieldName}); };
	}

	public function writeSelf(pos:Position, eField:Expr, fieldName:String):Expr {
		return macro @:pos(pos) { output.writeBool($v{fieldName}, ${eField}); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

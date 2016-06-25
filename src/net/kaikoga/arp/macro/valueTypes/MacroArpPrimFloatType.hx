package net.kaikoga.arp.macro.valueTypes;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpFieldType;
import haxe.macro.Expr;

class MacroArpPrimFloatType implements IMacroArpValueType {

	public function new() {
	}

	public function nativeType():ComplexType {
		return macro:Float;
	}

	public function arpFieldType():ArpFieldType {
		return ArpFieldType.PrimFloat(new ArpType("Float"));
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

	public function readSelf(pos:Position, eField:Expr, fieldName:String):Expr {
		return macro @:pos(pos) { ${eField} = input.readDouble($v{fieldName}); };
	}

	public function writeSelf(pos:Position, eField:Expr, fieldName:String):Expr {
		return macro @:pos(pos) { output.writeDouble($v{fieldName}, ${eField}); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

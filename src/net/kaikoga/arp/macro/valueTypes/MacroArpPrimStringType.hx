package net.kaikoga.arp.macro.valueTypes;

#if macro

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.reflect.ArpFieldType;
import haxe.macro.Expr;
class MacroArpPrimStringType implements IMacroArpValueType {

	public function new() {
	}

	public function nativeType():ComplexType {
		return macro:String;
	}

	public function arpFieldType():ArpFieldType {
		return ArpFieldType.PrimString(new ArpType("String"));
	}

	public function createEmptyVo(pos:Position):Expr {
		return macro @:pos(pos) { null; };
	}

	public function createSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { element.value(); };
	}

	public function readSeedElement(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = element.value(); };
	}

	public function readSelf(pos:Position, eField:Expr, fieldName:String):Expr {
		// if (nonNull)
		// return macro @:pos(pos) { ${eField} = input.readUtf($v{fieldName}); };
		return macro @:pos(pos) { ${eField} = net.kaikoga.arp.persistable.PersistableTool.readNullableUtf(input, $v{fieldName}); };
	}

	public function writeSelf(pos:Position, eField:Expr, fieldName:String):Expr {
		// if (nonNull)
		// return macro @:pos(pos) { output.writeUtf($v{iFieldName}, ${eField}); };
		return macro @:pos(pos) { net.kaikoga.arp.persistable.PersistableTool.writeNullableUtf(output, $v{fieldName}, ${eField}); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

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

	public function createAsPersistable(pos:Position, eName:Expr):Expr {
		// if (nonNull)
		// return macro @:pos(pos) { input.readUtf(${eName}); };
		return macro @:pos(pos) { net.kaikoga.arp.persistable.PersistableTool.readNullableUtf(input, ${eName}); };
	}

	public function readAsPersistable(pos:Position, eName:Expr, iFieldName:String):Expr {
		// if (nonNull)
		// return macro @:pos(pos) { this.$iFieldName = input.readUtf(${eName}); };
		return macro @:pos(pos) { this.$iFieldName = net.kaikoga.arp.persistable.PersistableTool.readNullableUtf(input, ${eName}); };

	}

	public function writeAsPersistable(pos:Position, eName:Expr, eValue:Expr):Expr {
		// if (nonNull)
		// return macro @:pos(pos) { output.writeUtf($v{iFieldName}, ${eValue}); };
		return macro @:pos(pos) { net.kaikoga.arp.persistable.PersistableTool.writeNullableUtf(output, ${eName}, ${eValue}); };

	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName = src.$iFieldName; };
	}
}

#end

package net.kaikoga.arp.macro.valueTypes;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldType;
import haxe.macro.Expr;

class MacroArpStructType implements IMacroArpValueType {

	private var _nativeType:ComplexType;
	private var nativeTypePath:TypePath;

	public function new(nativeType:ComplexType) {
		_nativeType = nativeType;
		switch (nativeType) {
			case ComplexType.TPath(typePath):
				this.nativeTypePath = typePath;
			case _: throw "invalid native type";
		}
	}

	public function nativeType():ComplexType return _nativeType;
	public function arpFieldType():ArpFieldType {
		return ArpFieldType.StructType(MacroArpObjectRegistry.arpTypeOf(_nativeType));
	}

	public function createEmptyVo(pos:Position):Expr {
		return {
			pos:pos,
			expr:ExprDef.ENew(this.nativeTypePath, [])
		};
	}

	public function createSeedElement(pos:Position):Expr {
		return macro @:pos(pos) { ${this.createEmptyVo(pos)}.initWithSeed(element); };
	}

	public function readSeedElement(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName.initWithSeed(element); };
	}

	public function createAsPersistable(pos:Position, eName:Expr):Expr {
		return macro @:pos(pos) { input.readPersistable(${eName}, ${this.createEmptyVo(pos)}); };
	}

	public function readAsPersistable(pos:Position, eName:Expr, iFieldName:String):Expr {
		return macro @:pos(pos) { input.readPersistable(${eName}, this.$iFieldName); };
	}

	public function writeAsPersistable(pos:Position, eName:Expr, eValue:Expr):Expr {
		return macro @:pos(pos) { output.writePersistable(${eName}, ${eValue}); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName.copyFrom(src.$iFieldName); };
	}
}

#end

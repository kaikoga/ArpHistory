package net.kaikoga.arp.macro.valueTypes;

#if macro

import haxe.macro.Expr;

class MacroArpObjectArpStruct implements IMacroArpObjectValueType {

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

	public function readSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { input.readPersistable(${eColumnName}, this.$iFieldName); };
	}

	public function writeSelf(pos:Position, iFieldName:String, eColumnName:ExprOf<String>):Expr {
		return macro @:pos(pos) { output.writePersistable(${eColumnName}, this.$iFieldName); };
	}

	public function copyFrom(pos:Position, iFieldName:String):Expr {
		return macro @:pos(pos) { this.$iFieldName.copyFrom(src.$iFieldName); };
	}
}

#end

package net.kaikoga.arp.macro.fields;

#if macro

import haxe.macro.Expr;

class MacroArpObjectValueField extends MacroArpObjectFieldBase implements IMacroArpObjectField {

	public var type(default, null):IMacroArpObjectValueType;

	public function new(nativeField:Field, nativeType:ComplexType, type:IMacroArpObjectValueType) {
		super(nativeField, nativeType);
		this.type = type;
	}

	public function buildField(outFields:Array<Field>):Void {
		outFields.push(this.nativeField);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = ${this.type.createEmptyVo(this.nativePos)}; });
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) $v{iFieldName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { ${this.type.readSeedElement(this.nativePos, this.iFieldName)}; });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { ${this.type.readSelf(this.nativePos, this.iFieldName)}; });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { ${this.type.writeSelf(this.nativePos, this.iFieldName)}; });
	}
}

#end

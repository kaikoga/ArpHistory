package net.kaikoga.arp.macro.fields;

#if macro

import net.kaikoga.arp.macro.fields.base.MacroArpFieldBase;
import haxe.macro.Expr;

class MacroArpValueField extends MacroArpFieldBase implements IMacroArpField {

	public var type(default, null):IMacroArpValueType;

	public function new(definition:MacroArpFieldDefinition, type:IMacroArpValueType) {
		super(definition);
		this.type = type;
	}

	public function buildField(outFields:Array<Field>):Void {
		var iField:String = this.iFieldName;
		var i_field:String = this.i_field;
		var iGet_field:String = this.iGet_field;
		var iSet_field:String = this.iSet_field;
		var nativeType:ComplexType = this.nativeType;

		var generated:Array<Field> = (macro class Generated {
			@:pos(this.nativePos)
			private var $i_field:$nativeType = ${this.definition.nativeDefault};
			@:pos(this.nativePos)
			inline private function $iGet_field():$nativeType return this.$i_field;
			@:pos(this.nativePos)
			inline private function $iSet_field(value:$nativeType):$nativeType return this.$i_field = value;
		}).fields;
		this.nativeField.kind = FieldType.FProp("get", "set", nativeType, null);
		this.nativeField.meta.push({ name: ":isVar", pos : this.nativeField.pos });
		outFields.push(this.nativeField);
		for (g in generated) outFields.push(g);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		if (this.definition.nativeDefault == null) {
			initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = ${this.type.createEmptyVo(this.nativePos)}; });
		}
	}

	public function buildHeatLaterBlock(heatLaterBlock:Array<Expr>):Void {
		heatLaterBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildHeatUpBlock(heatUpBlock:Array<Expr>):Void {
		heatUpBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildHeatDownBlock(heatDownBlock:Array<Expr>):Void {
		heatDownBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildDisposeBlock(initBlock:Array<Expr>):Void {
		initBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;
		var eColumnName:ExprOf<String> = this.eColumnName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) ${eColumnName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { ${this.type.readSeedElement(this.nativePos, this.iFieldName)}; });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { ${this.type.readSelf(this.nativePos, this.iFieldName, this.eColumnName)}; });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { ${this.type.writeSelf(this.nativePos, this.iFieldName, this.eColumnName)}; });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) { ${this.type.copyFrom(this.nativePos, this.iFieldName)}; });
	}
}

#end

package net.kaikoga.arp.macro.fields;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldKind;
import net.kaikoga.arp.macro.fields.base.MacroArpFieldBase;
import haxe.macro.Expr;

class MacroArpValueField extends MacroArpFieldBase implements IMacroArpField {

	public var type(default, null):IMacroArpValueType;
	override private function get_arpFieldKind():ArpFieldKind return this.type.arpFieldKind();

	public function new(definition:MacroArpFieldDefinition, type:IMacroArpValueType) {
		super(definition);
		this.type = type;
	}

	public function buildField(outFields:Array<Field>):Void {
		var generated:Array<Field> = (macro class Generated {
			@:pos(this.nativePos)
			private var $i_nativeName:$nativeType = ${this.definition.nativeDefault};
			@:pos(this.nativePos)
			/* inline */ private function $iGet_nativeName():$nativeType return this.$i_nativeName;
			@:pos(this.nativePos)
			/* inline */ private function $iSet_nativeName(value:$nativeType):$nativeType return this.$i_nativeName = value;
		}).fields;
		this.nativeField.kind = FieldType.FProp("get", "set", nativeType, null);
		this.nativeField.meta.push({ name: ":isVar", pos : this.nativeField.pos });
		outFields.push(this.nativeField);
		for (g in generated) outFields.push(g);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		if (this.definition.nativeDefault == null) {
			initBlock.push(macro @:pos(this.nativePos) { this.$iNativeName = ${this.type.createEmptyVo(this.nativePos)}; });
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
		var iNativeName:String = this.iNativeName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [this.eFieldName],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { ${this.type.readSeedElement(this.nativePos, this.iNativeName)}; });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { ${this.type.readAsPersistable(this.nativePos, this.eFieldName, this.iNativeName)}; });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		var eField:Expr = macro @:pos(this.nativePos) this.$iNativeName;
		fieldBlock.push(macro @:pos(this.nativePos) { ${this.type.writeAsPersistable(this.nativePos, this.eFieldName, eField)}; });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) { ${this.type.copyFrom(this.nativePos, this.iNativeName)}; });
	}
}

#end

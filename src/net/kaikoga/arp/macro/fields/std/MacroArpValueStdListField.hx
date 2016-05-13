package net.kaikoga.arp.macro.fields.std;

#if macro

import net.kaikoga.arp.macro.fields.base.MacroArpValueCollectionFieldBase;
import haxe.macro.Expr;

class MacroArpValueStdListField extends MacroArpValueCollectionFieldBase implements IMacroArpField {

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.type.nativeType();
		return macro:List;
	}

	public function new(definition:MacroArpFieldDefinition, type:IMacroArpValueType) {
		super(definition, type, true);
	}

	public function buildField(outFields:Array<Field>):Void {
		var nativeType:ComplexType = this.nativeType;
		this.nativeField.kind = FieldType.FProp("default", "null", nativeType, this.definition.nativeDefault);
		outFields.push(nativeField);
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

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) $v{this.eColumnName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.add(${this.type.createSeedElement(this.nativePos)}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = haxe.Unserializer.run(input.readUtf($v{iFieldName})); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, haxe.Serializer.run(this.$iFieldName)); });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			this.$iFieldName = new List();
			for (v in src.$iFieldName) this.$iFieldName.add(v);
		});
	}
}

#end

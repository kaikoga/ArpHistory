package net.kaikoga.arp.macro.fields.std;

#if macro

import haxe.macro.Expr;

class MacroArpObjectStdMapField extends MacroArpObjectFieldBase implements IMacroArpObjectField {

	public var type(default, null):IMacroArpObjectValueType;

	public function new(definition:MacroArpObjectFieldDefinition, type:IMacroArpObjectValueType) {
		super(definition);
		this.type = type;
	}

	public function buildField(outFields:Array<Field>):Void {
		var nativeType:ComplexType = this.nativeType;
		this.nativeField.kind = FieldType.FProp("default", "null", nativeType, null);
		outFields.push(nativeField);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = new Map(); });
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
		initBlock.push(macro @:pos(this.nativePos) { null; } );
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;
		var eColumnName:ExprOf<String> = this.eColumnName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) ${eColumnName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.set(element.key(uniqId), ${this.type.createSeedElement(this.nativePos)}); });
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
			this.$iFieldName = new Map();
			for (k in src.$iFieldName.keys()) this.$iFieldName.set(k, src.$iFieldName.get(k));
		});
	}
}

#end

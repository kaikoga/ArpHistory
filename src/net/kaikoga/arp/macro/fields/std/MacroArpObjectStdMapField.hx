package net.kaikoga.arp.macro.fields.std;

#if macro

import haxe.macro.Expr;

class MacroArpObjectStdMapField extends MacroArpObjectFieldBase implements IMacroArpObjectField {

	public var type(default, null):IMacroArpObjectValueType;

	public function new(nativeField:Field, nativeType:ComplexType, type:IMacroArpObjectValueType) {
		super(nativeField, nativeType);
		this.type = type;
	}

	public function buildField(outFields:Array<Field>):Void {
		var nativeType:ComplexType = this.nativeType;
		// TODO coerce type
		this.nativeField.kind = FieldType.FProp("default", "null", nativeType, null);
		outFields.push(nativeField);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = new Map(); });
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) $v{iFieldName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.set(element.key(), ${this.type.createSeedElement(this.nativePos)}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = haxe.Unserializer.run(input.readUtf($v{iFieldName})); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, haxe.Serializer.run(this.$iFieldName)); });
	}
}

#end

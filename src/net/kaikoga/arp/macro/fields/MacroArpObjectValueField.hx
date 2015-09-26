package net.kaikoga.arp.macro.fields;

#if macro

import haxe.macro.Expr;

class MacroArpObjectValueField extends MacroArpObjectField {

	public var type(default, null):MacroArpObjectValueType;

	public function new(nativeField:Field, nativeType:ComplexType, type:MacroArpObjectValueType) {
		super(nativeField, nativeType);
		this.type = type;
	}

	override public function buildField(outFields:Array<Field>):Void {
		outFields.push(this.nativeField);
	}

	override public function buildInitBlock(initBlock:Array<Expr>):Void {
		// do nothing
	}

	override public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) $v{iFieldName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		switch (this.type) {
			case MacroArpObjectValueType.PrimInt:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = Std.parseInt(element.value()); });
			case MacroArpObjectValueType.PrimFloat:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = Std.parseFloat(element.value()); });
			case MacroArpObjectValueType.PrimBool:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = element.value() == "true"; });
			case MacroArpObjectValueType.PrimString:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = element.value(); });
		}
	}

	override public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectValueType.PrimInt:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readInt32($v{iFieldName}); });
			case MacroArpObjectValueType.PrimFloat:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readDouble($v{iFieldName}); });
			case MacroArpObjectValueType.PrimBool:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readBool($v{iFieldName}); });
			case MacroArpObjectValueType.PrimString:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readUtf($v{iFieldName}); });
		}
	}

	override public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectValueType.PrimInt:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeInt32($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectValueType.PrimFloat:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeDouble($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectValueType.PrimBool:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeBool($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectValueType.PrimString:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, this.$iFieldName); });
		}
	}
}

#end

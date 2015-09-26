package net.kaikoga.arp.macro.fields.std;

#if macro

import haxe.macro.Expr.Field;

class MacroArpObjectStdArrayField extends MacroArpObjectField {

	public function new(nativeField:Field, nativeType:ComplexType, type:MacroArpObjectFieldType) {
		super(nativeField, nativeType, type);
	}
	override public function buildField(outFields:Array<Field>):Void {
		var nativeType:ComplexType = this.nativeType;
		switch (this.type) {
			case
			MacroArpObjectFieldType.PrimInt,
			MacroArpObjectFieldType.PrimFloat,
			MacroArpObjectFieldType.PrimBool,
			MacroArpObjectFieldType.PrimString:
				// TODO coerce type
				this.nativeField.kind = FieldType.FProp("default", "null", nativeType, null);
			case
				MacroArpObjectFieldType.Reference(arpType):
				// TODO coerce type
				this.nativeField.kind = FieldType.FProp("default", "null", macro :net.kaikoga.arp.domain.ds.ArpObjectArray, null);
		}
		outFields.push(nativeField);
	}

	override public function buildInitBlock(initBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case
			MacroArpObjectFieldType.PrimInt,
			MacroArpObjectFieldType.PrimFloat,
			MacroArpObjectFieldType.PrimBool,
			MacroArpObjectFieldType.PrimString:
				initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = []; });
			case
			MacroArpObjectFieldType.Reference(arpType):
				initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = new net.kaikoga.arp.domain.ds.ArpObjectArray(domain)); });
		}
	}

	override public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) $v{iFieldName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(Std.parseInt(element.value())); });
			case MacroArpObjectFieldType.PrimFloat:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(Std.parseFloat(element.value())); });
			case MacroArpObjectFieldType.PrimBool:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(element.value() == "true"); });
			case MacroArpObjectFieldType.PrimString:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(element.value()); });
			case MacroArpObjectFieldType.Reference(arpType):
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(this._arpDomain.loadSeed(element, new net.kaikoga.arp.domain.core.ArpType(${arpType})).value); });
		}
	}

	override public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				throw "not implemented";
			case MacroArpObjectFieldType.PrimFloat:
				throw "not implemented";
			case MacroArpObjectFieldType.PrimBool:
				throw "not implemented";
			case MacroArpObjectFieldType.PrimString:
				throw "not implemented";
			case MacroArpObjectFieldType.Reference(arpType):
				throw "not implemented";
		}
	}

	override public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				throw "not implemented";
			case MacroArpObjectFieldType.PrimFloat:
				throw "not implemented";
			case MacroArpObjectFieldType.PrimBool:
				throw "not implemented";
			case MacroArpObjectFieldType.PrimString:
				throw "not implemented";
			case MacroArpObjectFieldType.Reference(arpType):
				throw "not implemented";
		}
	}
}

#end

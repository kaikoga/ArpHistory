package net.kaikoga.arp.macro.fields.std;

#if macro

import haxe.macro.Expr.Field;

class MacroArpObjectReferenceStdArrayField extends MacroArpObjectField {

	private var arpType:ExprOf<String>;

	public function new(nativeField:Field, nativeType:ComplexType, arpType:ExprOf<String>) {
		super(nativeField, nativeType);
		this.arpType = arpType;
	}

	override public function buildField(outFields:Array<Field>):Void {
		var nativeType:ComplexType = this.nativeType;
		switch (this.type) {
			case
			MacroArpObjectValueType.PrimInt,
			MacroArpObjectValueType.PrimFloat,
			MacroArpObjectValueType.PrimBool,
			MacroArpObjectValueType.PrimString:
				// TODO coerce type
				this.nativeField.kind = FieldType.FProp("default", "null", nativeType, null);
			case
				MacroArpObjectValueType.Reference(arpType):
				// TODO coerce type
				this.nativeField.kind = FieldType.FProp("default", "null", macro :net.kaikoga.arp.domain.ds.ArpObjectArray, null);
		}
		outFields.push(nativeField);
	}

	override public function buildInitBlock(initBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case
			MacroArpObjectValueType.PrimInt,
			MacroArpObjectValueType.PrimFloat,
			MacroArpObjectValueType.PrimBool,
			MacroArpObjectValueType.PrimString:
				initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = []; });
			case
			MacroArpObjectValueType.Reference(arpType):
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
			case MacroArpObjectValueType.PrimInt:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(Std.parseInt(element.value())); });
			case MacroArpObjectValueType.PrimFloat:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(Std.parseFloat(element.value())); });
			case MacroArpObjectValueType.PrimBool:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(element.value() == "true"); });
			case MacroArpObjectValueType.PrimString:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(element.value()); });
			case MacroArpObjectValueType.Reference(arpType):
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.push(this._arpDomain.loadSeed(element, new net.kaikoga.arp.domain.core.ArpType(${arpType})).value); });
		}
	}

	override public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectValueType.PrimInt:
				throw "not implemented";
			case MacroArpObjectValueType.PrimFloat:
				throw "not implemented";
			case MacroArpObjectValueType.PrimBool:
				throw "not implemented";
			case MacroArpObjectValueType.PrimString:
				throw "not implemented";
			case MacroArpObjectValueType.Reference(arpType):
				throw "not implemented";
		}
	}

	override public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectValueType.PrimInt:
				throw "not implemented";
			case MacroArpObjectValueType.PrimFloat:
				throw "not implemented";
			case MacroArpObjectValueType.PrimBool:
				throw "not implemented";
			case MacroArpObjectValueType.PrimString:
				throw "not implemented";
			case MacroArpObjectValueType.Reference(arpType):
				throw "not implemented";
		}
	}
}

#end

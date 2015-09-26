package net.kaikoga.arp.macro.fields;

#if macro

import haxe.macro.Expr.Field;

class MacroArpObjectValueField extends MacroArpObjectField {

	public function new(nativeField:Field, nativeType:ComplexType, type:MacroArpObjectFieldType) {
		super(nativeField, nativeType, type);
	}

	override private function buildSlot(outFields:Array<Field>, fieldArpType:ExprOf<String>):Void {
		var iFieldSlot:String = this.iFieldSlot;
		var iGet_field:String = this.iGet_field;
		var iSet_field:String = this.iSet_field;
		var nativeType:ComplexType = this.nativeType;
		var nativeSlotType:ComplexType = this.nativeSlotType;

		var generated:Array<Field> = (macro class Generated {
			@:pos(this.nativePos) public var $iFieldSlot:$nativeSlotType;
			@:pos(this.nativePos) inline private function $iGet_field():$nativeType return this.$iFieldSlot.value;
			@:pos(this.nativePos) inline private function $iSet_field(value:$nativeType):$nativeType { this.$iFieldSlot = value.arpSlot(); return value; }
		}).fields;
		this.nativeField.kind = FieldType.FProp("get", "set", nativeType, null);
		outFields.push(nativeField);
		for (g in generated) outFields.push(g);
	}

	override public function buildField(outFields:Array<Field>):Void {
		switch (this.type) {
			case
			MacroArpObjectFieldType.PrimInt,
			MacroArpObjectFieldType.PrimFloat,
			MacroArpObjectFieldType.PrimBool,
			MacroArpObjectFieldType.PrimString:
				outFields.push(this.nativeField);
			case
			MacroArpObjectFieldType.Reference(fieldArpType):
				this.buildSlot(outFields, fieldArpType);
		}
	}

	override public function buildInitBlock(initBlock:Array<Expr>):Void {
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
			case MacroArpObjectFieldType.PrimFloat:
			case MacroArpObjectFieldType.PrimBool:
			case MacroArpObjectFieldType.PrimString:
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = this.iFieldSlot;
				initBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.nullSlot; });
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
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = Std.parseInt(element.value()); });
			case MacroArpObjectFieldType.PrimFloat:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = Std.parseFloat(element.value()); });
			case MacroArpObjectFieldType.PrimBool:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = element.value() == "true"; });
			case MacroArpObjectFieldType.PrimString:
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = element.value(); });
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = this.iFieldSlot;
				caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.loadSeed(element, new net.kaikoga.arp.domain.core.ArpType(${arpType})); });
		}
	}

	override public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readInt32($v{iFieldName}); });
			case MacroArpObjectFieldType.PrimFloat:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readDouble($v{iFieldName}); });
			case MacroArpObjectFieldType.PrimBool:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readBool($v{iFieldName}); });
			case MacroArpObjectFieldType.PrimString:
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = input.readUtf($v{iFieldName}); });
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = this.iFieldSlot;
				fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.getOrCreateSlot(new net.kaikoga.arp.domain.core.ArpSid(input.readUtf($v{iFieldName}))); });
		}
	}

	override public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		switch (this.type) {
			case MacroArpObjectFieldType.PrimInt:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeInt32($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.PrimFloat:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeDouble($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.PrimBool:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeBool($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.PrimString:
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, this.$iFieldName); });
			case MacroArpObjectFieldType.Reference(arpType):
				var iFieldSlot:String = iFieldName + "Slot";
				fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, this.$iFieldSlot.sid.toString()); });
		}
	}
}

#end

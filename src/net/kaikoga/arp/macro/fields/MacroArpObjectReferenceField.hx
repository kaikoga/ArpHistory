package net.kaikoga.arp.macro.fields;

#if macro

import haxe.macro.Expr;

class MacroArpObjectReferenceField extends MacroArpObjectFieldBase implements IMacroArpObjectField {

	private var nativeSlotType(get, never):ComplexType;
	inline private function get_nativeSlotType():ComplexType {
		return ComplexType.TPath({
			pack: "net.kaikoga.arp.domain".split("."), name: "ArpSlot", params: [TypeParam.TPType(this.nativeType)]
		});
	}
	private var iFieldSlot(get, never):String;
	private function get_iFieldSlot():String return this.iFieldName + "Slot";

	public function new(definition:MacroArpObjectFieldDefinition) {
		super(definition);
		if (definition.nativeDefault != null) throw "can't inline initialize arp reference field";
	}

	public function buildField(outFields:Array<Field>):Void {
		var iFieldSlot:String = this.iFieldSlot;
		var iGet_field:String = this.iGet_field;
		var iSet_field:String = this.iSet_field;
		var nativeType:ComplexType = this.nativeType;
		var nativeSlotType:ComplexType = this.nativeSlotType;

		var generated:Array<Field> = (macro class Generated {
			@:pos(this.nativePos)
			public var $iFieldSlot:$nativeSlotType;
			@:pos(this.nativePos)
			inline private function $iGet_field():$nativeType return this.$iFieldSlot.value;
			@:pos(this.nativePos)
			inline private function $iSet_field(value:$nativeType):$nativeType {
			value.arpSlot().takeReference(this.$iFieldSlot);
			return value;
			}
		}).fields;
		this.nativeField.kind = FieldType.FProp("get", "set", nativeType, null);
		outFields.push(nativeField);
		for (g in generated) outFields.push(g);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		var iFieldSlot:String = this.iFieldSlot;
		initBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = slot.domain.nullSlot; });
	}

	public function buildHeatLaterBlock(heatLaterBlock:Array<Expr>):Void {
		if (this.metaArpBarrier) {
			heatLaterBlock.push(macro @:pos(this.nativePos) { this._arpDomain.heatLater(this.$iFieldSlot); });
		}
	}

	public function buildHeatUpBlock(heatUpBlock:Array<Expr>):Void {
		heatUpBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildHeatDownBlock(heatDownBlock:Array<Expr>):Void {
		heatDownBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildDisposeBlock(disposeBlock:Array<Expr>):Void {
		var iFieldSlot:String = this.iFieldSlot;
		disposeBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot.delReference(); this.$iFieldSlot = null; });
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;
		var eColumnName:ExprOf<String> = this.eColumnName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) ${eColumnName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		var iFieldSlot:String = this.iFieldSlot;
		caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.loadSeed(element, new net.kaikoga.arp.domain.core.ArpType(${this.metaArpType})); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		var iFieldSlot:String = this.iFieldSlot;
		fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = this._arpDomain.getOrCreateSlot(new net.kaikoga.arp.domain.core.ArpSid(input.readUtf(${this.eColumnName}))); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		var iFieldSlot:String = iFieldName + "Slot";
		fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf(${this.eColumnName}, this.$iFieldSlot.sid.toString()); });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) { this.$iFieldSlot = src.$iFieldSlot.takeReference(this.$iFieldSlot); });
	}
}

#end
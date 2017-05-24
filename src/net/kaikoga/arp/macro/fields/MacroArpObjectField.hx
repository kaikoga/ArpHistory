package net.kaikoga.arp.macro.fields;

#if macro

import net.kaikoga.arp.macro.fields.base.MacroArpFieldBase;
import haxe.macro.Expr;

class MacroArpObjectField extends MacroArpFieldBase implements IMacroArpField {

	private var nativeSlotType(get, never):ComplexType;
	inline private function get_nativeSlotType():ComplexType {
		return ComplexType.TPath({
			pack: "net.kaikoga.arp.domain".split("."), name: "ArpSlot", params: [TypeParam.TPType(this.nativeType)]
		});
	}

	public function new(fieldDef:MacroArpFieldDefinition) {
		super(fieldDef);
		if (fieldDef.nativeDefault != null) {
			MacroArpUtil.error("can't inline initialize arp reference field", fieldDef.nativePos);
		}
	}

	public function buildField(outFields:Array<Field>):Void {
		var generated:Array<Field> = (macro class Generated {
			@:pos(this.nativePos)
			public var $iNativeSlot:$nativeSlotType;
			@:pos(this.nativePos)
			/* inline */ private function $iGet_nativeName():$nativeType return this.$iNativeSlot.value;
			@:pos(this.nativePos)
			/* inline */ private function $iSet_nativeName(value:$nativeType):$nativeType {
				this.$iNativeSlot= net.kaikoga.arp.domain.ArpSlot.of(value, this._arpDomain).takeReference(this.$iNativeSlot);
				return value;
			}
		}).fields;
		this.nativeField.kind = FieldType.FProp("get", "set", nativeType, null);
		outFields.push(nativeField);
		for (g in generated) outFields.push(g);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		initBlock.push(macro @:pos(this.nativePos) { this.$iNativeSlot = slot.domain.nullSlot; });
	}

	public function buildHeatLaterBlock(heatLaterBlock:Array<Expr>):Void {
		if (this.arpBarrier) {
			heatLaterBlock.push(macro @:pos(this.nativePos) { this._arpDomain.heatLater(this.$iNativeSlot); });
		}
	}

	public function buildHeatUpBlock(heatUpBlock:Array<Expr>):Void {
		if (this.arpBarrier) {
			heatUpBlock.push(macro @:pos(this.nativePos) { if (this.$iNativeSlot.heat != net.kaikoga.arp.domain.ArpHeat.Warm) return false; });
		}
	}

	public function buildHeatDownBlock(heatDownBlock:Array<Expr>):Void {
		heatDownBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildDisposeBlock(disposeBlock:Array<Expr>):Void {
		disposeBlock.push(macro @:pos(this.nativePos) { this.$iNativeSlot.delReference(); this.$iNativeSlot = null; });
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [this.eFieldName],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iNativeSlot = this._arpDomain.loadSeed(element, ${this.eArpType}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { this.$iNativeSlot = this._arpDomain.getOrCreateSlot(new net.kaikoga.arp.domain.core.ArpSid(input.readUtf(${this.eFieldName}))); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf(${this.eFieldName}, this.$iNativeSlot.sid.toString()); });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) { this.$iNativeSlot = src.$iNativeSlot.addReference(); });
	}
}

#end

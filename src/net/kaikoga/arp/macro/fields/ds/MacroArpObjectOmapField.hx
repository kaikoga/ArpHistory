package net.kaikoga.arp.macro.fields.ds;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.macro.fields.base.MacroArpObjectCollectionFieldBase;
import haxe.macro.Expr;

class MacroArpObjectOmapField extends MacroArpObjectCollectionFieldBase implements IMacroArpField {

	override private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.DsIOmap;

	private var _nativeType:ComplexType;
	override private function get_nativeType():ComplexType return _nativeType;

	// use impl, because we have to directly get/set slots
	private function coerce(nativeType:ComplexType):ComplexType {
		switch (nativeType) {
			case ComplexType.TPath(t):
				return ComplexType.TPath({
					pack: "net.kaikoga.arp.domain.ds".split("."),
					name: "ArpObjectOmap",
					params: t.params
				});
			case _:
		}
		return nativeType;
	}

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.contentNativeType;
		return macro:net.kaikoga.arp.domain.ds.ArpObjectOmap<String, $contentNativeType>;
	}

	public function new(definition:MacroArpFieldDefinition, contentNativeType:ComplexType, concreteDs:Bool) {
		super(definition, contentNativeType, concreteDs);
		if (!concreteDs) _nativeType = coerce(super.nativeType);
	}

	public function buildField(outFields:Array<Field>):Void {
		var nativeType:ComplexType = this.nativeType;
		this.nativeField.kind = FieldType.FProp("default", "null", nativeType, this.definition.nativeDefault);
		outFields.push(nativeField);
	}

	public function buildHeatLaterBlock(heatLaterBlock:Array<Expr>):Void {
		if (this.arpBarrier) {
			heatLaterBlock.push(macro @:pos(this.nativePos) { for (slot in this.$iNativeName.slotOmap) this._arpDomain.heatLater(slot); });
		}
	}

	public function buildHeatUpBlock(heatUpBlock:Array<Expr>):Void {
		if (this.arpBarrier) {
			heatUpBlock.push(macro @:pos(this.nativePos) { if (this.$iNativeName.heat != net.kaikoga.arp.domain.ArpHeat.Warm) return false; });
		}
	}

	public function buildHeatDownBlock(heatDownBlock:Array<Expr>):Void {
		heatDownBlock.push(macro @:pos(this.nativePos) { null; });
	}

	public function buildDisposeBlock(initBlock:Array<Expr>):Void {
		initBlock.push(macro @:pos(this.nativePos) { null; } );
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [this.eFieldName],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iNativeName.slotOmap.addPair(element.key, this._arpDomain.loadSeed(element, ${this.eArpType})); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) {
			input.readPersistable(${this.eFieldName}, this.$iNativeName);
		});
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) {
			output.writePersistable(${this.eFieldName}, this.$iNativeName);
		});
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			this.$iNativeName.clear();
			for (k in src.$iNativeName.keys()) this.$iNativeName.addPair(k, src.$iNativeName.get(k));
		});
	}
}

#end

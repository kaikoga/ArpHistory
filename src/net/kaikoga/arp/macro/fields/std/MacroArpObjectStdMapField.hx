package net.kaikoga.arp.macro.fields.std;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.macro.fields.base.MacroArpObjectCollectionFieldBase;
import haxe.macro.Expr;

class MacroArpObjectStdMapField extends MacroArpObjectCollectionFieldBase implements IMacroArpField {

	override private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.StdMap;

	private var _nativeType:ComplexType;
	override private function get_nativeType():ComplexType return _nativeType;

	// acts as if Map will resolve to ArpObjectStdMap with @:multiType()
	private function coerce(nativeType:ComplexType):ComplexType {
		switch (nativeType) {
			case ComplexType.TPath(t):
				return ComplexType.TPath({
					pack: "net.kaikoga.arp.domain.ds.std".split("."),
					name: "ArpObjectStdMap",
					params: [t.params[1]]
				});
			case _:
		}
		return nativeType;
	}

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.contentNativeType;
		return macro:net.kaikoga.arp.domain.ds.std.ArpObjectStdMap<$contentNativeType>;
	}

	public function new(definition:MacroArpFieldDefinition, contentNativeType:ComplexType, concreteDs:Bool) {
		super(definition, contentNativeType, concreteDs);
		if (definition.nativeDefault != null) throw "can't inline initialize arp reference field";
		_nativeType = coerce(super.nativeType);
	}

	public function buildField(outFields:Array<Field>):Void {
		this.nativeField.kind = FieldType.FProp("default", "null", this.nativeType, null);
		outFields.push(nativeField);
	}

	public function buildHeatLaterBlock(heatLaterBlock:Array<Expr>):Void {
		if (this.arpBarrier) {
			heatLaterBlock.push(macro @:pos(this.nativePos) { for (slot in this.$iNativeName.slots) this._arpDomain.heatLater(slot); });
		}
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
		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [this.eFieldName],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iNativeName.slots.set(element.key(uniqId), this._arpDomain.loadSeed(element, ${this.eArpType})); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { input.readPersistable(${this.eFieldName}, this.$iNativeName); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) { output.writePersistable(${this.eFieldName}, this.$iNativeName); });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			for (k in this.$iNativeName.keys()) this.$iNativeName.remove(k);
			for (k in src.$iNativeName.keys()) this.$iNativeName.set(k, src.$iNativeName.get(k));
		});
	}
}

#end
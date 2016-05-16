package net.kaikoga.arp.macro.fields.ds;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.macro.fields.base.MacroArpObjectCollectionFieldBase;
import haxe.macro.Expr;

class MacroArpObjectSetField extends MacroArpObjectCollectionFieldBase implements IMacroArpField {

	override private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.DsISet;

	private var _nativeType:ComplexType;
	override private function get_nativeType():ComplexType return _nativeType;

	// use impl, because we have to directly get/set slots
	private function coerce(nativeType:ComplexType):ComplexType {
		switch (nativeType) {
			case ComplexType.TPath(t):
				return ComplexType.TPath({
					pack: "net.kaikoga.arp.domain.ds".split("."),
					name: "ArpObjectSet",
					params: t.params
				});
			case _:
		}
		return nativeType;
	}

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.contentNativeType;
		return macro:net.kaikoga.arp.domain.ds.ArpObjectSet<$contentNativeType>;
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
		heatLaterBlock.push(macro @:pos(this.nativePos) { null; });
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
			values: [macro @:pos(this.nativePos) $v{this.fieldName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iNativeName.slotSet.add(this._arpDomain.loadSeed(element, ${this.eArpType})); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { this.$iNativeName = haxe.Unserializer.run(input.readUtf($v{iNativeName})); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iNativeName}, haxe.Serializer.run(this.$iNativeName)); });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			this.$iNativeName.clear();
			for (v in src.$iNativeName) this.$iNativeName.add(v);
		});
	}
}

#end

package net.kaikoga.arp.macro.fields.std;

#if macro

import haxe.macro.Expr;

class MacroArpObjectStdReferenceMapField extends MacroArpObjectFieldBase implements IMacroArpObjectField {

	private var arpType:ExprOf<String>;
	private var arpBarrier:Bool;

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

	public function new(nativeField:Field, nativeType:ComplexType, arpType:ExprOf<String>, arpBarrier:Bool) {
		super(nativeField, coerce(nativeType));
		this.arpType = arpType;
		this.arpBarrier = arpBarrier;
	}

	public function buildField(outFields:Array<Field>):Void {
		this.nativeField.kind = FieldType.FProp("default", "null", this.nativeType, null);
		outFields.push(nativeField);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = new net.kaikoga.arp.domain.ds.std.ArpObjectStdMap(slot.domain); });
	}

	public function buildHeatLaterBlock(heatLaterBlock:Array<Expr>):Void {
		if (arpBarrier) heatLaterBlock.push(macro @:pos(this.nativePos) { for (slot in this.$iFieldName.slots) this._arpDomain.heatLater(slot); });
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
		var iFieldName:String = this.iFieldName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) $v{iFieldName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.set(element.key(), this._arpDomain.loadSeed(element, new net.kaikoga.arp.domain.core.ArpType(${this.arpType})).value); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { input.readPersistable($v{iFieldName}, this.$iFieldName); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { output.writePersistable($v{iFieldName}, this.$iFieldName); });
	}
}

#end

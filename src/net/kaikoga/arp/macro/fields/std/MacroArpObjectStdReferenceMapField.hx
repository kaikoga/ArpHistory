package net.kaikoga.arp.macro.fields.std;

#if macro

import haxe.macro.Expr;

class MacroArpObjectStdReferenceMapField extends MacroArpObjectFieldBase implements IMacroArpObjectField {

	private var arpType:ExprOf<String>;

	public function new(nativeField:Field, nativeType:ComplexType, arpType:ExprOf<String>) {
		super(nativeField, nativeType);
		this.arpType = arpType;
	}

	public function buildField(outFields:Array<Field>):Void {
		var nativeType:ComplexType = macro :net.kaikoga.arp.domain.ds.ArpObjectMap<net.kaikoga.arp.macro.mocks.MockStdDsMacroArpObject>;
		// TODO coerce type
		this.nativeField.kind = FieldType.FProp("default", "null", nativeType, null);
		outFields.push(nativeField);
	}

	public function buildInitBlock(initBlock:Array<Expr>):Void {
		var iFieldName:String = this.iFieldName;
		initBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = new net.kaikoga.arp.domain.ds.ArpObjectMap(slot.domain); });
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

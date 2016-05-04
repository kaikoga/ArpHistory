package net.kaikoga.arp.macro.fields.ds;

#if macro

import net.kaikoga.arp.macro.fields.base.MacroArpObjectValueTypeCollectionFieldBase;
import haxe.macro.Expr;

class MacroArpObjectOmapField extends MacroArpObjectValueTypeCollectionFieldBase implements IMacroArpObjectField {

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.type.nativeType();
		return macro:net.kaikoga.arp.ds.impl.StdOmap<String, $contentNativeType>;
	}

	public function new(definition:MacroArpObjectFieldDefinition, type:IMacroArpObjectValueType, concreteDs:Bool) {
		super(definition, type, concreteDs);
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
		initBlock.push(macro @:pos(this.nativePos) { null; } );
	}

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var iFieldName:String = this.iFieldName;
		var eColumnName:ExprOf<String> = this.eColumnName;

		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [macro @:pos(this.nativePos) ${eColumnName}],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iFieldName.addPair(element.key(uniqId), ${this.type.createSeedElement(this.nativePos)}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { this.$iFieldName = haxe.Unserializer.run(input.readUtf($v{iFieldName})); });
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		// FIXME persist over serialize
		fieldBlock.push(macro @:pos(this.nativePos) { output.writeUtf($v{iFieldName}, haxe.Serializer.run(this.$iFieldName)); });
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			this.$iFieldName.clear();
			for (k in src.$iFieldName.keys()) this.$iFieldName.addPair(k, src.$iFieldName.get(k));
		});
	}
}

#end

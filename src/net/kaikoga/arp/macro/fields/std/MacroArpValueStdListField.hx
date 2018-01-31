package net.kaikoga.arp.macro.fields.std;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.macro.fields.base.MacroArpValueCollectionFieldBase;
import haxe.macro.Expr;

class MacroArpValueStdListField extends MacroArpValueCollectionFieldBase implements IMacroArpField {

	override private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.StdList;

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.type.nativeType();
		return macro:List;
	}

	public function new(fieldDef:MacroArpFieldDefinition, type:IMacroArpValueType) {
		super(fieldDef, type, true);
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
			values: [this.eFieldName],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$iNativeName.add(${this.type.createSeedElement(this.nativePos)}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		// intentionally serialized
		fieldBlock.push(macro @:pos(this.nativePos) {
			this.$i_nativeName = haxe.Unserializer.run(input.readUtf($v{iNativeName}));
		});
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		// intentionally serialized
		fieldBlock.push(macro @:pos(this.nativePos) {
			output.writeUtf($v{iNativeName}, haxe.Serializer.run(this.$iNativeName));
		});
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			this.$i_nativeName = new List();
			for (v in src.$iNativeName) this.$iNativeName.add(v);
		});
	}
}

#end

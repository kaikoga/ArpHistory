package arp.macro.fields.ds;

#if macro

import haxe.macro.Expr;
import arp.domain.reflect.ArpFieldDs;
import arp.macro.fields.base.MacroArpValueCollectionFieldBase;

class MacroArpValueListField extends MacroArpValueCollectionFieldBase implements IMacroArpField {

	override private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.DsIList;

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.type.nativeType();
		return macro:arp.ds.impl.ArrayList<$contentNativeType>;
	}

	public function new(fieldDef:MacroArpFieldDefinition, type:IMacroArpValueType, concreteDs:Bool) {
		super(fieldDef, type, concreteDs);
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

		caseBlock.push(macro @:pos(this.nativePos) { this.$i_nativeName.push(${this.type.createSeedElement(this.nativePos)}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) {
			collection = input.readEnter(${eFieldName});
			nameList = collection.readNameList("keys");
			values = input.readEnter("values");
			for (name in nameList) {
				this.$i_nativeName.push(${this.type.createAsPersistable(this.nativePos, macro name)});
			}
			values.readExit();
			collection.readExit();
		});
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) {
			collection = output.writeEnter(${eFieldName});
			uniqId.reset();
			collection.writeNameList("keys", [for (value in this.$i_nativeName) uniqId.next()]);
			values = output.writeEnter("values");
			uniqId.reset();
			for (value in this.$i_nativeName) {
				${this.type.writeAsPersistable(this.nativePos, macro uniqId.next(), macro value)}
			}
			values.writeExit();
			collection.writeExit();
		});
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			this.$i_nativeName.clear();
			for (v in src.$i_nativeName) this.$i_nativeName.push(v);
		});
	}
}

#end

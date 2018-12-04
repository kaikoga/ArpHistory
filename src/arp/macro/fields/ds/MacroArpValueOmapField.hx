package arp.macro.fields.ds;

#if macro

import arp.domain.reflect.ArpFieldDs;
import arp.macro.defs.MacroArpFieldDefinition;
import arp.macro.fields.base.MacroArpValueCollectionFieldBase;
import arp.macro.stubs.ds.MacroArpSwitchBlock;
import haxe.macro.Expr;

class MacroArpValueOmapField extends MacroArpValueCollectionFieldBase implements IMacroArpField {

	override private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.DsIOmap;

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.type.nativeType();
		return macro:arp.ds.impl.StdOmap<String, $contentNativeType>;
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
		initBlock.push(macro @:pos(this.nativePos) { null; } );
	}

	public function buildConsumeSeedElementBlock(cases:MacroArpSwitchBlock):Void {
		var caseBlock:Array<Expr> = [];
		cases.pushCase(this.eFieldName, this.nativePos, caseBlock);

		caseBlock.push(macro @:pos(this.nativePos) { this.$i_nativeName.addPair(element.key, ${this.type.createSeedElement(this.nativePos)}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) {
			collection = input.readEnter(${eFieldName});
			nameList = collection.readNameList("keys");
			values = input.readEnter("values");
			for (name in nameList) {
				this.$i_nativeName.addPair(name, ${this.type.createAsPersistable(this.nativePos, macro name)});
			}
			values.readExit();
			collection.readExit();
		});
	}

	public function buildWriteSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) {
			collection = output.writeEnter(${eFieldName});
			collection.writeNameList("keys", [for (key in this.$i_nativeName.keys()) key]);
			values = output.writeEnter("values");
			for (key in this.$i_nativeName.keys()) {
				${this.type.writeAsPersistable(this.nativePos, macro key, macro this.$i_nativeName.get(key))}
			}
			values.writeExit();
			collection.writeExit();
		});
	}

	public function buildCopyFromBlock(copyFromBlock:Array<Expr>):Void {
		copyFromBlock.push(macro @:pos(this.nativePos) {
			this.$i_nativeName.clear();
			for (k in src.$i_nativeName.keys()) this.$i_nativeName.addPair(k, src.$i_nativeName.get(k));
		});
	}
}

#end

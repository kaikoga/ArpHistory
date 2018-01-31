package net.kaikoga.arp.macro.fields.ds;

#if macro

import net.kaikoga.arp.domain.reflect.ArpFieldDs;
import net.kaikoga.arp.macro.fields.base.MacroArpValueCollectionFieldBase;
import haxe.macro.Expr;

class MacroArpValueMapField extends MacroArpValueCollectionFieldBase implements IMacroArpField {

	override private function get_arpFieldDs():ArpFieldDs return ArpFieldDs.DsIMap;

	override private function guessConcreteNativeType():ComplexType {
		var contentNativeType:ComplexType = this.type.nativeType();
		return macro:net.kaikoga.arp.ds.impl.StdMap<String, $contentNativeType>;
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

	public function buildConsumeSeedElementBlock(cases:Array<Case>):Void {
		var caseBlock:Array<Expr> = [];
		cases.push({
			values: [this.eFieldName],
			expr: { pos: this.nativePos, expr: ExprDef.EBlock(caseBlock)}
		});

		caseBlock.push(macro @:pos(this.nativePos) { this.$i_nativeName.set(element.key, ${this.type.createSeedElement(this.nativePos)}); });
	}

	public function buildReadSelfBlock(fieldBlock:Array<Expr>):Void {
		fieldBlock.push(macro @:pos(this.nativePos) {
			collection = input.readEnter(${eFieldName});
			nameList = collection.readNameList("keys");
			values = input.readEnter("values");
			for (name in nameList) {
				this.$i_nativeName.set(name, ${this.type.createAsPersistable(this.nativePos, macro name)});
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
			for (k in src.$i_nativeName.keys()) this.$i_nativeName.set(k, src.$i_nativeName.get(k));
		});
	}
}

#end

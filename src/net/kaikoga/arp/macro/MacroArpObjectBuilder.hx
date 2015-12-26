package net.kaikoga.arp.macro;

#if macro

import net.kaikoga.arp.macro.MacroArpObjectFieldBuilder;
import haxe.macro.Expr;
import haxe.macro.Context;

class MacroArpObjectBuilder extends MacroArpObjectStub {

	public static function build(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName).run();
	}

	public static function buildDerived(arpTypeName:String, arpTemplateName:String = null):Array<Field> {
		if (arpTemplateName == null) arpTemplateName = arpTypeName;
		return new MacroArpObjectBuilder(arpTypeName, arpTemplateName, true).run();
	}

	private function new(arpTypeName:String, arpTemplateName:String, isDerived:Bool = false) {
		this.arpTypeName = arpTypeName;
		this.arpTemplateName = arpTemplateName;
		this.isDerived = isDerived;
	}

	private function merge(target:Array<Field>, source:Array<Field>):Array<Field> {
		for (field in source) {
			var hasField:Bool = false;
			for (t in target) {
				if (field.name == t.name) hasField = true;
			}
			if (!hasField) target.push(field);
		}
		return target;
	}

	public function run() {
		var outFields:Array<Field> = [];

		for (field in Context.getBuildFields()) {
			var arpObjectField:IMacroArpObjectField = MacroArpObjectFieldBuilder.fromField(field);
			if (arpObjectField == null) {
				outFields.push(field);
			} else {
				this.arpObjectFields.push(arpObjectField);
				arpObjectField.buildField(outFields);
			}
		}

		if (this.isDerived) {
			outFields = merge(this.genDerivedTypeFields(), outFields);
		} else {
			outFields = merge(this.genTypeFields(), outFields);
			outFields = merge(outFields, this.genDefaultTypeFields());
		}

		return outFields;
	}
}

#end
